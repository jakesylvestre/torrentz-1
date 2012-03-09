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

    def download(query)
      results = Search.new(query).get
      logger.info "Found #{urls.size} candidates"
    end
  end
end
