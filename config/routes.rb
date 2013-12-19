# -*- encoding : utf-8 -*-
Blog::Application.routes.draw do
  root to: 'articles#index'

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get "about" => "users#about"

  resources :articles
  get "/articles/tagging/:tag", to: "articles#tagging", as: :tagging
end
