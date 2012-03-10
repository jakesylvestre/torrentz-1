require 'addressable/uri'

module Torrentz
  class Fetch
    include Torrentz::Logger

    attr_accessor :url

    def initialize(url)
      @url = url
    end

    def get
      {
        :magnet  => get_magnet,
        :torrent => get_torrent
      }
    end

    private

    def get_torrent
      candidate_urls.each do |candidate_url|
        case candidate_url
        when /vertor\.com/
          logger.info "Found Vertor: #{candidate_url}"
          return Vertor.new(candidate_url).get
        end
      end

      return torrent_from_torrentz_url
    end

    def get_magnet
      candidate_urls.each do |candidate_url|
        case candidate_url
        when /thepiratebay/
          logger.info "Found Piratebay: #{candidate_url}"
          return PirateBay.new(candidate_url).get
        end
      end

      return nil
    end

    def torrentz_doc
      @torrentz_doc ||= Nokogiri::HTML(open(Addressable::URI.encode(url)))
    end

    def candidate_urls
      @candidate_urls ||= begin
        torrentz_doc.css("div.download a[rel=e]").map{|a| a["href"]}
      end
    end

    ##
    # Uses torcache to try to fetch a torrent.
    def torrent_from_torrentz_url
      torrent_id = url.split("/").last
      "https://torcache.net/torrent/#{torrent_id}.torrent"
    end

    class Simple
      include Torrentz::Logger

      def initialize(url)
        @url = url
      end

      def doc
        @doc ||= Nokogiri::HTML(open(Addressable::URI.encode(@url)))
      end
    end

    ##
    # Currently returns magnet links only.
    class PirateBay < Simple
      def get
        a = doc.css(".download a").first['href']
      end
    end

    ##
    # Returns torrent urls only.
    class Vertor < Simple
      def get
        candidate = doc.css('ul.down_but li.bt a').map do |a|
          a['href']
        end.find do |url|
          url =~ /mod=download/
        end
      end
    end
  end
end
