module Torrentz
  class Fetch
    include Torrentz::Logger

    def initialize(url)
      @url = url
    end

    def torrent_url
      torrentz_doc = Nokogiri::HTML(open(@url))
      torrentz_doc.css("div.download a[rel=e]").each do |a|
        logger.info "Considering #{a["href"]}"
        case a["href"]
        when /thepiratebay/
          logger.info "Found Piratebay!"
          return PirateBay.new(a["href"]).get
        end
      end
    end

    def download
      open torrent_url
    end

    class PirateBay
      include Torrentz::Logger

      URL       = "http://thepiratebay.se/torrent/"
      ID_REGEXP = /thepiratebay\.\w\w\w?\/torrent\/(\d+)\//

      def initialize(url)
        url =~ ID_REGEXP
        @id  = $1
        logger.info "Torrent id = #{@id}"
      end

      def get
        doc = Nokogiri::HTML(open(URL + @id))
        a = doc.css(".download a").find { |a| a["href"] =~ /torrents.thepiratebay/}
        a ? a["href"] : nil
      end
    end
  end
end
