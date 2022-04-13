require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get '/' => "home#index"
  # root to: "home#index"
  # get '/about' => "articles#about"
  root to: 'articles#index'

  # resource :timeline, only: [:show]

  # resources :articles, only: [:show, :new, :create, :edit, :update, :destroy]
  # resources :articles
  # ↓ URL:articles/12/comments/1
  
  resources :articles
  # commentsとlikeをnamespaceでまとめる
  # resources :articles do
  #   resources :comments, only: [:index, :new, :create]

  #   # 記事にとってlikeは一つだけ複数形のresourcesにすると削除する際にlikesのidを付与しないといけなくなる, likeのidを使うと他人のlikeを消すことも、確実に自分のだけにするならidを使わない方が良い
  #   # レコードを作る場合はcreate

  #   # articleコントローラのlikeアクションができる
  #   # memberはIDを指定する
  #   # member do 
  #   #   post :like
  #   # end
  #   resource :like, only: [:show, :create, :destroy]
  # end

  resources :accounts, only: [:show] do
    resources :follows, only: [:create]
    resources :unfollows, only: [:create]
  end

  # resourceにすることでprofileを複数形にしなくて良い.indexを作らなくて良くなる.複数ないとindexは作成できないから
  # resource :profile, only: [:show, :edit, :update]
  
  # profile/publishのurlを作成 
  # collectionはIDを指定しない
  # resource :profile, only: [:show, :edit, :update] do
  #   collection do
  #     post 'publish'
  #   end
  # end

  # resources :favorites, only: [:index]

  # module => コントローラー（ディレクトリ）のみ変更 URLは変更しない
  # ログインしていないと動かないものをまとめる
  # コントローラーのディレクトリを移動させると、viewsのディレクトリも移動させる必要あり
  scope module: :apps do
    resources :favorites, only: [:index]
    resource :profile, only: [:show, :edit, :update]
    resource :timeline, only: [:show]
  end

  # namespace => URLとコントローラーどちらも変更する
  namespace :api, defaults: { format: :json } do
    # scope => URLのみ変更する コントローラー(ディレクトリ)は変えない
    scope '/articles/:article_id' do
      resources :comments, only: [:index, :create]
      resource :like, only: [:show, :create, :destroy]
    end
  end
end
