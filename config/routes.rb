Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get '/' => "home#index"
  # root to: "home#index"
  # get '/about' => "articles#about"
  root to: 'articles#index'

  # resources :articles, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :articles
end
