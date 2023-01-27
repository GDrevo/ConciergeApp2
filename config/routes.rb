Rails.application.routes.draw do
  devise_for :cleaners
  devise_for :users
  root to: "pages#home"

  resources :cleaners do
    resources :availabilities
  end
  resources :appointments
end
