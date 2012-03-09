require "torrentz/version"
require "rack"
require "nokogiri"
require "open-uri"

require 'torrentz/logger'
require 'torrentz/search'
require 'torrentz/fetch'

module Torrentz
  class << self
    include Torrentz::Logger

    def get(query)
      search_results = Search.new(query).get
      logger.info "Found #{search_results.size} candidates"

      return nil if search_results.empty?

      results = {}

      search_results.each do |search_result|
        results.merge!(Fetch.new(search_result.url).get)
        break if results[:torrent] && results[:magnet]
      end

      results
    end
  end
end
