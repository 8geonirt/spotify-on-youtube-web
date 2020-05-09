class SpotifyService
  attr_reader :token, :track_name

  def initialize(token, track_name = nil)
    @token = token
    @track_name = track_name
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
    user_response = RestClient.get(track_api_url, headers);
    user_params = JSON.parse(user_response.body);
    user_params['tracks']['items'].map { |item| item }
  end

  private

  def headers
    {
      Authorization: "Bearer #{token}"
    }
  end

  def track_api_url
    "https://api.spotify.com/v1/search?q=#{track_name}&type=track"
  end
end
