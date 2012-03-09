# Torrentz

Torrentz is a ruby gem that uses the powerful results from torrentz.eu to
provide magnet and torrent url's for a certain search query.

## Usage

To search:

    results = Torrentz::Search.new('The Big Bang Theory S05E04 720p').get
    results.size       # => 10
    results.first.name # => "The Big Bang Theory S05E04 720p HDTV x264 ORENJI"
    results.first.url  # => "http://torrentz.eu/deb2b19012810caa8d700c82506d3b9974fb42f9"

To get the actual magnet and torrent urls:

    results = Torrentz.get('The Big Bang Theory S05E04 720p')
    results[:magnet]  # => "magnet:?xt=urn:btih:09bb45c848ddc7f2687c..."
    results[:torrent] # => "http://www.vertor.com/index.php?mod=download..."

It will try to always return a magnet and a torrent, iterating from all the results
that torrentz.eu gives.

For now, magnets come from piratebay, and torrent files from vertor.
