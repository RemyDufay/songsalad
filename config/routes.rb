Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'


resources :games, only: [] do
  resources :game_sessions, only: [:create, :show] do
    resources :game_session_songs, only: [:create] do
      resources :guesses, only: [:create]
    end
    member do
      get :victory # score ici
    end
  end
end

resources :guests, only: [] do

  member do
    delete :reset
    get :stats
  end

end

resources :friendships, only: [:create, :index] do
  member do
    patch :decline
    patch :accept
    patch :cancel
  end
end

  # get '/solo', to: 'game_sessions#solo'
  # get '/playlist', to: 'game_sessions#playlist'
  get '/rules', to: 'pages#rules'
  get '/faq', to: 'pages#faq'
  # get '/guest/:id/score', to: 'guests#score'


end
