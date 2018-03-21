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


  post "home/back" => "home#back"
 post "home/renew" => "home#renew"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
