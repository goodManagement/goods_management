Rails.application.routes.draw do
  resources :items

  devise_for :users, :controllers => {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'home/index'

  devise_scope :user do
    root to: 'devise/registrations#new'
  end

  post "home/back" => "home#return_item"
  post "home/renew" => "home#renew_item"

  post "items/searcha" => "items#search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
