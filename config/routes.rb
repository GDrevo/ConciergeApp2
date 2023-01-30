Rails.application.routes.draw do
  devise_for :cleaners
  devise_for :users
  root to: "pages#home"

  resources :cleaners do
    resources :availabilities, only: %i[new index create destroy]
  end
  get '/appointments/available_cleaners' => 'appointments#available_cleaners'
  resources :appointments, only: %i[new create edit update show destroy available_cleaners]
end
