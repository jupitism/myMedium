Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # /@jupitism/文章標題-123
  get "@:username/:story_id", to: "pages#show", as: "story_page"
  get "@:username", to: "pages#user", as: "user_page"

  # /users/:id/follow
  resources :users, only:[] do
    member do
      post :follow
    end
  end

  # stories/story_id/clap
  resources :stories do
    member do
      post :clap
    end
    resources :comments, only:[:create]
  end

  get "/demo", to: 'pages#demo'

  root 'pages#index'
end
