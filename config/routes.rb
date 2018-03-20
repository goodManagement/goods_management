Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  resources :lendings

  devise_scope :user do
    root to: 'devise/registrations#new'
  end

  post "home/back" => "home#back"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
