module Torrentz
  class Search
    include Rack::Utils

    attr_reader :url

    URL = "http://kat.ph/usearch/%s/?field=seeders&sorder=desc"

    def initialize(query)
      @url = URL % escape(query)
    end

    def get
      doc = Nokogiri::HTML(open(url))

      table = doc.css('table.data')

      names    = table.css('.torrentname>a.plain').map { |a| a.text }
      magnets  = table.css('a.imagnet').map { |a| a[:href] }
      torrents = table.css('a.idownload').map { |a| a[:href] }.select { |url| url =~ /torcache/ }
      seed     = table.css('td.green').map(&:text)
      leech    = table.css('td.red').map(&:text)

      names.zip(magnets, torrents, seed, leech).map do |name, magnet, torrent, seed, leech|
        Result.new(name, magnet, torrent, seed, leech)
      end
    end
  end
end
