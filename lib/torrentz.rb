require "torrentz/version"
require "rack"
require "nokogiri"
require "open-uri"

require 'torrentz/logger'
require 'torrentz/result'
require 'torrentz/search'
require 'torrentz/fetch'

module Torrentz
  class << self
    include Torrentz::Logger

    def get(query)
      results = Search.new(query).get
      logger.info "Found #{results.size} candidates"

      return nil if results.empty?

      {
        :torrent => results.first.torrent,
        :magnet  => results.first.magnet
      }
    end
  end
end
