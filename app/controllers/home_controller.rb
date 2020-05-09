# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :check_session, only: :index

  def index
    if params[:error]
      json_response({ error: params[:error] }, :unprocessable_entity)
    else
      response = SpotifyAuthorizationService.authorize_session(params[:code])
      set_session(response)
      json_response({ success: 'ok' })
    end
  end

  def authorize
    redirect_to SpotifyAuthorizationService.authorize_url
  end

  def user_info
    json_response(SpotifyService.new(user_token).user_info)
  end

  def track_info
    json_response(SpotifyService.new(user_token, track_param).track_info)
  end


  private

  def check_session
    authorize if params.empty? && session[:session_token].nil?
  end

  def user_token
    session[:user_token]
  end

  def refresh_token
    session[:refresh_token]
  end

  def track_param
    params[:name]
  end

  def set_session(response)
    session[:user_token] = response[:access_token]
    session[:refresh_token] = response[:refresh_token]
  end
end
