Rails.application.routes.draw do
  # admin ユーザーadmin
  get "admin/edit" => "admin#edit"
  patch "admin" => "admin#update"

  # item
  get "items/onloan" => "items#onloan"
  get "items/delete" => "items#delete"
  delete "items" => "items#destroy"
  resources :items, except: [:edit, :show, :update, :destroy]

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

  # api
  namespace :api, { format: 'json' } do
    namespace :v1 do # バージョン1を表している

      mount_devise_token_auth_for 'User', at: 'auth'

      namespace :items do
        get '/', action: 'index'
        post '/', action: 'search'
        # resources :items
      end

      namespace :lendings do
        get '/', action: 'index'
        patch '/', action: 'update'
        post '/', action: 'create'
        get '/', action: 'dead_line_params'
        post '/', action:'return_item'
        post '/', action: 'renew_item'
      end

      namespace :users do
        get '/', action: 'index'
        post '/', action: 'create'
      end
    end
  end
end
