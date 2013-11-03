Bacu::Application.routes.draw do
  resources :entries

  root to: 'entries#frontpage'
end
