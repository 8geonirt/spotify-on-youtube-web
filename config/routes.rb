Rails.application.routes.draw do
  root 'home#index'
  get '/authorize', to: 'home#authorize'
  get '/user_info', to: 'home#user_info'
  get '/track_info', to: 'home#track_info'
  get '/save_track/:id', to: 'home#save_track'
  get '/clear', to: 'home#clear'
  get '/authorized', to: 'home#authorized'
  get '/success', to: 'home#success'
  get '/lyrics', to: 'home#lyrics'
end
