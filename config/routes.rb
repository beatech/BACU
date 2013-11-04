Bacu::Application.routes.draw do
  resources :entries

  resources :circles, only: [:create]
  resource :circle, only: [:edit, :update] do
    member do
      get :welcome
    end
  end

  resources :users, only: [:create]
  resource :user, only: [:edit, :update] do
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

  resource :master, only: [] do
    member do
      get :index
    end
  end

  resources :games, only: [:index]

  get '/auth/twitter/callback' => 'sessions#twitter_create'
  resource :session, only: [:destroy]

  root to: 'entries#frontpage'
end
