# -*- encoding : utf-8 -*-
Blog::Application.routes.draw do
  root to: 'articles#index'
  delete 'logout' => 'sessions#logout'
  get "about" => "users#about"

  resources :articles
  resources :tags, only: [:show]

  match '/auth/:provider/callback', to: 'sessions#create'
end
