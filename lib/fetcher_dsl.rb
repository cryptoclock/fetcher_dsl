require "fetcher_dsl/version"
require "fetcher_dsl/fetcher"

require 'redis'

module FetcherDsl
  def self.define(&block)
    Fetcher.new(&block)
  end
end
