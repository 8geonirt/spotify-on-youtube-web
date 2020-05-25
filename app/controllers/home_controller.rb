# frozen_string_literal: true

class HomeController < ApplicationController
  include Response
  before_action :authenticate!, only: %w[track_info]
  before_action :refresh_token!, only: %w[track_info user_info save_track]

  def index;end

  def authorize
    redirect_to SpotifyAuthorizationService.authorize_url
  end


  def authorized
    if params[:error]
      @message = 'There was an error trying to authorize your account, please try again.'
    else
      authenticate(params[:code])
      @message = 'Now you can close this tab and return to Youtube'
    end
  end

  def clear
    session[:user_token] = nil
    session[:refresh_token] = nil
    json_response({ ok: 'ok' })
  end

  def user_info
    json_response(SpotifyService.new(user_token).user_info)
  end

  def track_info
    response = SpotifyService.new(user_token, track_param).track_info
    if !valid_token?(response)
      auth_response = reauthorize
      json_response({ error: 're-authenticate'}, :unprocessable_entity);
    else
      json_response(response)
    end
  end

  def save_track
    json_response(SpotifyService.new(user_token, track_id_param).save_track)
  end

  def lyrics
    response = LyricsService.new(artist_param, track_name_param).perform
    json_response(response)
  end

  private

  def authenticate!
    if user_token.nil?
      json_response({
        error: 'authorization_failed'
      }, :unprocessable_entity)
    end
  end

  def artist_param
    params['artist']
  end

  def track_name_param
    params['track_name']
  end

  def user_token
    session[:user_token]
  end

  def authenticate(code)
    response = SpotifyAuthorizationService.authorize_session(code)
    set_session(response)
  end

  def reauthorize
    response = SpotifyAuthorizationService.reauthorize(refresh_token)
    set_session(response, true)
  end

  def refresh_token
    session[:refresh_token]
  end

  def valid_token?(response)
    begin
      response['error']['status'] < 400
    rescue
      true
    end
  end

  def track_param
    params[:name]
  end

  def track_id_param
    params[:id]
  end

  def set_session(response, refresh = false)
    session[:user_token] = response[:access_token]
    session[:updated_at] = Time.now.to_i

    if !refresh
      session[:refresh_token] = response[:refresh_token]
    end
  end

  def refresh_token!
    if token_expired?
      reauthorize
    end
  end

  def token_expired?
    (Time.now.to_i - session[:updated_at]) > 3600
  end
end
