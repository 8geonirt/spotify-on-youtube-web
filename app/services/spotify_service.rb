class SpotifyService
  attr_reader :token, :track

  def initialize(token, track = nil)
    @token = token
    @track = track
  end

  def user_info
    user_response = RestClient.get('https://api.spotify.com/v1/me', headers);
    user_params = JSON.parse(user_response.body);

    {
      id: user_params['id'],
      user_url: user_params['external_urls']['spotify'],
      user_uri: user_params['uri'],
      display_name: user_params['display_name']
    }
  end

  def track_info
    begin
      response = RestClient.get(URI.escape(track_api_url), headers);
    rescue RestClient::Unauthorized,
      RestClient::Forbidden,
      RestClient::ExceptionWithResponse => err
      JSON.parse(err.response)
    else
      body = JSON.parse(response.body);
      body['tracks']['items'].map { |item| item }
    end
  end

  def save_track
    RestClient.put("https://api.spotify.com/v1/me/tracks?ids=#{track}", {}, headers);
    { status: :ok }
  end

  private

  def headers
    {
      Authorization: "Bearer #{token}",
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }
  end

  def track_api_url
    "https://api.spotify.com/v1/search?q=#{track}&type=track"
  end
end
