# frozen_string_literal: true

class SpotifyAuthorizationService
  class << self
    def authorize_url
      query_params = {
        client_id: ENV['SPOTIFY_CLIENT_ID'],
        response_type: 'code',
        redirect_uri: ENV['REDIRECT_URI'],
        scope: 'user-library-modify',
        show_dialog: true,
      }

      "https://accounts.spotify.com/authorize/?#{query_params.to_query}"
    end

    def authorize_session(code)
      body = {
        grant_type: 'authorization_code',
        code: code,
        redirect_uri: ENV['REDIRECT_URI'],
        client_id: ENV['SPOTIFY_CLIENT_ID'],
        client_secret: ENV['SPOTIFY_CLIENT_SECRET']
      }

      auth_response = RestClient.post('https://accounts.spotify.com/api/token', body)
      auth_params = JSON.parse(auth_response.body)
      {
        access_token: auth_params['access_token'],
        refresh_token: auth_params['refresh_token']
      }
    end
  end
end
