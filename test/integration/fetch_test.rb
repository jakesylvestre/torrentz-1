require 'test_helper'

describe Torrentz do
  it 'will find a file that resembles what was queried' do
    [
      'Big Bang Theory S05E04 720p',
      'House S01E01'
    ].each do |search|
      result = Torrentz.get(search)
      logger.info result.inspect

      torrent_info = Typhoeus::Request.get(result[:torrent], :follow_location => true).body.bdecode
      torrent_name = torrent_info['info']['name']

      size_difference = torrent_name.size - search.size
      size_difference * -1 if size_difference < 0

      smallest = [torrent_name.size, search.size].min
      distance = Text::Levenshtein.distance(torrent_name, search)
      logger.info "Distance of result: #{distance}"

      difference = (distance - size_difference) / smallest.to_f
      logger.info "Difference of result: #{difference}"

      difference.must_be_within_delta 0, 0.2
    end
  end
end
