class SpotifyFetcher

  def initialize
    @spotify_data_connection = Faraday.new(:url => 'https://api.spotify.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def composer(artist_name)
    response = @spotify_data_connection.get do |req|
      req.url "/v1/search"
      req.params['q'] = artist_name
      req.params['type'] = "artist"
      req.headers['Content-Type'] = 'application/json'
    end

    JSON.parse(response.body)
  end

end
