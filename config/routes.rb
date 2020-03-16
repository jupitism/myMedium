Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # /@jupitism/文章標題-123
  get "@:username/:story_id", to: "pages#show", as: "story_page"
  get "@:username", to: "pages#user", as: "user_page"

  # /api/users/:id/follow
  namespace :api do
    resources :users, only:[] do
      member do
        post :follow
      end
    end
  end

  # /api/stories/story_id/bookmark
  # /api/stories/story_id/clap
  namespace :api do
    resources :stories, only:[] do
      member do
        post :clap
        post :bookmark
      end
    end
  end

  resources :stories do
    resources :comments, only:[:create]
  end

  get "/demo", to: 'pages#demo'

  root 'pages#index'
end
