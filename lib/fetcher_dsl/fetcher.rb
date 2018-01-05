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
      @publisher.publish ["fetcher",@name,keys].flatten.join("_").downcase, value
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
  end
end
