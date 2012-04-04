module Torrentz
  class Result
    include Torrentz::Logger

    attr_reader :name, :magnet, :torrent, :seed, :leech

    def initialize(name, magnet, torrent, seed, leech)
      @name, @magnet, @torrent, @seed, @leech = name, magnet, torrent, seed.to_i, leech.to_i
    end
  end
end
