require 'logger'

module Torrentz
  module Logger
    def logger
      @@logger ||= ::Logger.new($stdout)
    end
  end
end
