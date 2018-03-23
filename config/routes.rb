Rails.application.routes.draw do
  get "items/onloan" => "items#onloan"
  get "items/delete" => "items#delete"
  delete "items" => "items#destroy"
  post "items/search" => "items#search"
  resources :items, except: :destroy


  devise_for :users, :controllers => {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'home/index'
  patch "lendings" => "lendings#update"
  resources :lendings, except: [:show, :update]

  devise_scope :user do
    root to: 'devise/registrations#new'
  end

  post "home/back" => "home#return_item"
  post "home/renew" => "home#renew_item"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
