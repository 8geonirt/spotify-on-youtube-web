Rails.application.routes.draw do
  get '/authorize', to: 'home#authorize'
  get '/user_info', to: 'home#user_info'
  get '/track_info', to: 'home#track_info'
  get '/save_track/:id', to: 'home#save_track'
  get '/clear', to: 'home#clear'
  get '/authorized', to: 'home#authorized'
  get '/lyrics', to: 'home#lyrics'
end
