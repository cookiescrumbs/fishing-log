module WebMockHelpers
  module GoogleApis
    def stub_google_geocode_lat_lng
      body = File.read('spec/fixtures/googleapis/geocode/manchester.json')
      stub_request(:get, /https:\/\/maps.googleapis.com\/maps\/api\/geocode\/json\?key=([\w\W]+)&language=en&latlng=(\-?\d+(\.\d+)?),\s*(\-?\d+(\.\d+)?)&sensor=false/)
        .to_return(status: 200, body: body, headers: {})
    end

    def stub_google_geocode_address
      body = File.read('spec/fixtures/googleapis/geocode/manchester.json')
      stub_request(:get, /https:\/\/maps.googleapis.com\/maps\/api\/geocode\/json\?address=([\w\W]+)&key=([\w\W]+)&language=en&sensor=false/)
        .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: body, headers: {})
    end

    def stub_google_places_details
      body = File.read('spec/fixtures/googleapis/place/stocks_fly_fishery.json')
      stub_request(:get, /https:\/\/maps.googleapis.com\/maps\/api\/place\/details\/json\?key=([\w\W]+)&language=en&placeid=([a-zA-Z{0-9}])/)
        .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: body, headers: {})
    end

    def stub_google_places_near_by_search
      body = File.read('spec/fixtures/googleapis/place/near_by_search.json')
      stub_request(:get, /https:\/\/maps.googleapis.com\/maps\/api\/place\/nearbysearch\/json\?key=([\w\W]+)&location=(\-?\d+(\.\d+)?),\s*(\-?\d+(\.\d+)?)&radius=([\w\W]+)&types=([\w\W]+)/)
        .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: body, headers: {})
    end

  end



  module Geograph
    def stub_geograph_photo_details
      body = File.read('spec/fixtures/geograph/photo-details.json')
      stub_request(:get, /http:\/\/api.geograph.org.uk\/api\/photo\/([\d]+)\?key=([\w\W]+)&output=jso/)
        .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: body, headers: { 'Content-Type' => 'application/json' })
    end
  end

  module DarkSky
    def stub_dark_sky
      body = File.read('spec/fixtures/dark_sky/forecast.json')
      stub_request(:get, /https:\/\/api.darksky.net\/forecast\/([\w\W]+)\/(\-?\d+(\.\d+)?),\s*(\-?\d+(\.\d+)?)/)
        .with(headers: { 'Accept' => '*/*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: body, headers: { 'Content-Type' => 'application/json' })
    end
  end
end
