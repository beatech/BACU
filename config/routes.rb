Bacu::Application.routes.draw do
  resources :entries

  resources :circles, only: [:index, :show, :create]
  resource :circle, only: [:edit, :update] do
    member do
      get :welcome
    end
  end

  resources :users, only: [:create] do
    member do
      get :master_circle_edit
      post :master_circle_update
      get :games_circle_edit
      post :games_circle_update
    end
  end
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
      get :edit
      post :update
    end
  end
  namespace :master do
    resources :musics, only: [:index]
  end

  namespace :games do
    resources :musics, only: [:index]
  end
  resources :games, only: [:index] do
    member do
      post :score_ranking
      post :master_score_ranking
    end
  end
  resource :game, only: [] do
    member do
      get :edit
      post :update
    end
  end

  get '/auth/twitter/callback' => 'sessions#twitter_create'
  resource :session, only: [:destroy]

  root to: 'entries#frontpage'
end
