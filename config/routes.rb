Rails.application.routes.draw do
  get 'game_sessions/create'
  get 'game_sessions/show'
  devise_for :users
  root to: 'pages#home'

  resources :game_sessions, only: [:create, :show] do
    resources :guesses, only: [:create]

    member do
      get :victory # score ici
    end

  end

  resources :guests, only: [] do

    member do
      delete :reset
      get :stats
    end

  end

  get '/rules', to: 'pages#rules'
  get '/faq', to: 'pages#faq'
  # get '/guest/:id/score', to: 'guests#score'
  # get '/game_sessions/:id/victory', to: 'game_sessions#victory'

end
