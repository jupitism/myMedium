Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # /@jupitism/文章標題-123
  get "@:username/:story_id", to: "pages#show", as: "story_page"
  get "@:username", to: "pages#user", as: "user_page"

  resources :stories
  root 'pages#index'
end
