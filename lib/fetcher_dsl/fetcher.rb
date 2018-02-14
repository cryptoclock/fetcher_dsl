require 'redis'

module FetcherDsl
  class Fetcher
    attr_accessor :name, :processor, :publisher, :period

    def initialize(&block)
      @publisher = Redis.new(host:"redis")
      @period=0
      instance_eval(&block)
    end

    def name(value=nil)
      if value
        @name=value
        @publisher.sadd("fetchers", @name)
      else
        @name
      end
    end

    def process(&block)
      @processor = block
    end

    def publish(keys,value)
      @publisher.publish channel_name(keys), value
    end

    def delay(value)
      @period=value
    end

    def run
      loop {
        instance_eval(&@processor)
        @publisher.hmset("fetcher_next_run", @name, (Time.now+period).to_i)
        sleep(@period)
      }
    end

    private
    def channel_name(keys)
      unless keys.kind_of?(Array)
        keys=keys.scan(/.{3}/) if keys.length==6
      end
      ["cryptoclock","ticker",[@name,keys].flatten.join("_")].join(":").downcase
    end
  end
end
