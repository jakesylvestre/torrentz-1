module Torrentz
  class Search
    include Rack::Utils

    attr_reader :url

    URL = "http://kat.ph/search/%s/?rss=1&field=seeders&sorder=desc"

    def initialize(query)
      @url = URL % escape(query)
    end

    def get
      doc = Nokogiri::XML(open(url))
      torrents = doc.xpath('//rss/channel/item/torrentLink').map(&:text)
      hashes   = doc.xpath('//rss/channel/item/hash').map(&:text)
      names    = doc.xpath('//rss/channel/item/title').map(&:text)

      names.zip(hashes, torrents).map do |name, hash, torrent|
        Result.new(name, hash, torrent)
      end
    end
  end
end
