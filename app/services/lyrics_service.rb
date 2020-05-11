# frozen_string_literal: true

class LyricsService
  attr_reader :artist, :track_name

  def initialize(artist, track_name)
    @artist = artist
    @track_name = track_name
  end

  def perform
    begin
      response = RestClient.get(URI.escape(lyrics_api_url), headers)
    rescue RestClient::Unauthorized,
      RestClient::Forbidden,
      RestClient::ExceptionWithResponse => err
      {
          error: true
      }
    else
      JSON.parse(response.body)
    end
  end

  private

  def lyrics_api_url
    "#{ENV['LYRICS_API_URL']}#{artist}/#{track_name}?apikey=#{ENV['LYRICS_API_TOKEN']}"
  end

  def headers
    {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Accept': 'application/json'
    }
  end
end
