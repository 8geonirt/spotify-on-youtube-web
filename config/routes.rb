Rails.application.routes.draw do
  get '/', to: 'home#index'
  get '/authorize', to: 'home#authorize'
  get '/user_info', to: 'home#user_info'
  get '/track_info', to: 'home#track_info'
end
