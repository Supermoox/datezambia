Rails.application.routes.draw do

  devise_for :users
  resources :comments
  resources :user_interests
  resources :interests
  resources :cities
  resources :searches
  resources :messages
  resources :visits


  resources :conversations, only: [:create, :index] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end
  

  resources :users, only: [:index, :show] do
    member do
      post :add_favourite
    end
  	resources :pictures do 
      resources :comments
      member do
        put "like" => "pictures#vote"
        patch :make_profile_pic
      end
    end
  end

  resources :pictures do  
  	member do
      put "like" => "pictures#vote"
  		patch :make_profile_pic
      post :reset
  	end
    resources :comments
  end

  mount ActionCable.server => '/cable'

  root 'pages#home'
  get 'pages/users_online'
  get 'pages/recently_online'
  get 'pages/users_offline'
  get 'pages/visitors'
  get 'pages/notifications'
  get 'pages/history'
  get 'pages/favourites'
  get 'pages/blocked'
end
