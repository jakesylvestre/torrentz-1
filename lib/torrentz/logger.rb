require 'logger'

module Torrentz
  module Logger
    def logger
      @@logger ||= ::Logger.new($stdout)
    end

    def logger=(logger)
      @@logger = logger
    end
  end
end
