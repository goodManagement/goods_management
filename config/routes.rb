Rails.application.routes.draw do
  # item
  get "items/onloan" => "items#onloan"
  get "items/delete" => "items#delete"
  delete "items" => "items#destroy"
  resources :items, except: :destroy

  # lending
  patch "lendings" => "lendings#update"
  resources :lendings, except: [:show, :update]

  # user
  devise_for :users, :controllers => {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    root to: 'devise/registrations#new'
  end

  # home
  get 'home/index'
  post "home/back" => "home#return_item"
  post "home/renew" => "home#renew_item"

end
