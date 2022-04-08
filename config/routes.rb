Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get '/' => "home#index"
  # root to: "home#index"
  # get '/about' => "articles#about"
  root to: 'articles#index'

  # resources :articles, only: [:show, :new, :create, :edit, :update, :destroy]
  # resources :articles
  # ↓ URL:articles/12/comments/1
  resources :articles do
    resources :comments, only: [:new, :create]

    # 記事にとってlikeは一つだけ複数形のresourcesにすると削除する際にlikesのidを付与しないといけなくなる, likeのidを使うと他人のlikeを消すことも、確実に自分のだけにするならidを使わない方が良い
    # レコードを作る場合はcreate
    resource :like, only: [:create, :destroy]
  end

  resources :accounts, only: [:show] do
    resources :follows, only: [:create]
    resources :unfollows, only: [:create]
  end

  # resourceにすることでprofileを複数形にしなくて良い.indexを作らなくて良くなる.複数ないとindexは作成できないから
  resource :profile, only: [:show, :edit, :update]

  resources :favorites, only: [:index]
end
