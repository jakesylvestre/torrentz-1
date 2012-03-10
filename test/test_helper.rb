require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/spec'
require 'open-uri'
require 'text'
require 'bencode'
require 'typhoeus'
require 'torrentz'

begin
  require 'ruby-debug'
rescue LoadError; end

include Torrentz::Logger
