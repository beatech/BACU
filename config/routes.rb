Bacu::Application.routes.draw do
  resources :entries

  resources :circles, only: [:create]
  resource :circle, only: [] do
    member do
      get :welcome
    end
  end

  resources :users, only: [:create]
  resource :user, only: [] do
    member do
      get :welcome
    end
  end

  resource :registration, controller: 'registration' do
    member do
      get :index
      post :create
      get :member
      get :circle
    end
  end

  get '/auth/twitter/callback' => 'sessions#twitter_create'

  root to: 'entries#frontpage'
end
