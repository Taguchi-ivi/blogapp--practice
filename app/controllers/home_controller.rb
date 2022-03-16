class HomeController < ApplicationController

    # 下記に現状の色んな情報が乗っている
    # http://localhost:3000/rails/info/routes

    def index
        # ルールで書かなくても表示させるようになっている
        # render 'home/index'
        @title = 'デイトラ'
    end

    def about
        @title = 'ABOUT'
        # 書かなくても表示させる
        # render 'home/about'
    end
end