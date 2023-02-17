Rails.application.routes.draw do
  devise_for :cleaners
  devise_for :users
  root to: "pages#home"
  get 'about', to: "pages#about"
  get 'faq', to: "pages#faq"

  resources :cleaners, only: [:show] do
    resources :availabilities, only: %i[new index create destroy]
  end
  get '/appointments/available_cleaners' => 'appointments#available_cleaners'
  resources :appointments, only: %i[new create edit update show destroy available_cleaners]
  resources :checkins, only: %i[show]

  resources :contacts, only: %i[new create]
  get '/contacts', to: 'contacts#new', as: 'contact'
  get 'contacts/sent'
end
