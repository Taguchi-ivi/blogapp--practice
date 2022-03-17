class ArticlesController < ApplicationController

    # 下記に現状の色んな情報が乗っている
    # http://localhost:3000/rails/info/routes

    def index
        # ルールで書かなくても表示させるようになっている
        # render 'home/index'
        @articles = Article.all
    end

    def show
        @article = Article.find(params[:id])
    end

    # def about
    # end

    
end