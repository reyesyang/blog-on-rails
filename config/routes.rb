# -*- encoding : utf-8 -*-
Blog::Application.routes.draw do
  root to: 'articles#index'

  post '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get "about" => "users#about"

  resources :articles
  resources :tags, only: [:show]
end
