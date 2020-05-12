# frozen_string_literal: true

class LyricsService
  attr_reader :artist, :track_name

  def initialize(artist, track_name)
    @artist = artist
    @track_name = track_name
  end

  def perform
    begin
      response = RestClient.get(URI.escape(track_url));
    rescue RestClient::Unauthorized,
      RestClient::Forbidden,
      RestClient::ExceptionWithResponse => err
      JSON.parse(err.response)
    else
      body = JSON.parse(response.body);
      get_lyrics(body['message']['body']['track']['track_id'])
    end
  end

  private

  def get_lyrics(track_id)
    begin
      response = RestClient.get(URI.escape(lyrics_url(track_id)));
    rescue RestClient::Unauthorized,
      RestClient::Forbidden,
      RestClient::ExceptionWithResponse => err
      JSON.parse(err.response)
    else
      body = JSON.parse(response.body);
      body['message']['body']['lyrics']
    end
  end

  def token
    ENV['LYRICS_API_TOKEN']
  end

  def api_url
    "https://api.musixmatch.com/ws/1.1/"
  end

  def track_url
    "#{api_url}matcher.track.get?format=json&q_artist=#{artist}&q_track=#{track_name}&apikey=#{token}"
  end

  def lyrics_url(track_id)
    "#{api_url}track.lyrics.get?format=json&&track_id=#{track_id}&apikey=#{token}"
  end
end
