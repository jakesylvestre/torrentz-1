module Torrentz
  class Search
    include Rack::Utils

    URL = "http://torrentz.eu/feed?q="

    def initialize(query)
      @url = URL + escape(query)
    end

    def get
      @urls ||= urls_from(@url)
    end

    class Result
      attr_reader :url, :name

      def initialize(url, name)
        @url, @name = url, name
      end
    end

    private

    def urls_from(url)
      doc = Nokogiri::XML(open(url))
      urls  = doc.xpath('//rss/channel/item/guid').map(&:text)
      names = doc.xpath('//rss/channel/item/title').map(&:text)

      urls.zip(names).map do |url, name|
        Result.new(url, name)
      end
    end
  end
end
