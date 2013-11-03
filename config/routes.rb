Bacu::Application.routes.draw do
  resources :entries
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
