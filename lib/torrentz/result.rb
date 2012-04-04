module Torrentz
  class Result
    include Torrentz::Logger

    attr_reader :name, :hash, :torrent

    def initialize(name, hash, torrent)
      @name, @hash, @torrent = name, hash, torrent
    end
  end
end
