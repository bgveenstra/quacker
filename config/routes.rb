Rails.application.routes.draw do
  get "hashtags/:hashtag",   to: "hashtags#show",      as: :hashtag
  get "hashtags",            to: "hashtags#index",     as: :hashtags
  root to: "homepage#index"

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

  patch "tweets/:id/like", to: "tweets#like", as: "like_tweet"
  patch "tweets/:id/dislike", to: "tweets#dislike", as:"dislike_tweet"

  get 'users/search/:id', to: "users#search", as: "user_search"

  get "/tweets", to: "tweets#index", as: "tweets"
  get "/tweets/new", to: "tweets#new", as: "new_tweet"
  get "/tweets/:id", to: "tweets#show", as: "tweet"
  get "/tweets/:id/edit", to: "tweets#edit", as: "edit_tweet"
  post "/tweets/", to: "tweets#create"
  patch "/tweets/:id", to: "tweets#update"
  delete "/tweets/:id", to: "tweets#destroy", as: "destroy_tweet"

  get "/tweets/:id/comments", to: "comments#index", as: "comments"
  get "/tweets/:id/comments/new", to: "comments#new", as: "new_comment"
  get "/tweets/:id/comments/:comment_id", to: "comments#show", as: "comment"
  get "/tweets/:id/comments/:comment_id/edit", to: "comments#edit", as: "tweet_comment"
  post "/tweets/:id/comments", to: "comments#create"
  patch "/tweets/:id/comments/:comment_id", to: "comments#update", as:"comment_update"
  delete "/tweets/:id/comments/:comment_id", to: "comments#destroy", as: "destroy_comment"

  get 'hashtags/',         to: 'hashtags#index',     as: :hashtags
  get 'hashtags/:hashtag', to: 'hashtags#show',      as: :hashtag

  get "/login", to: "sessions#new"
  post "/sessions", to: "sessions#create", as: "sessions"
  get "/logout", to: "sessions#destroy"
end
