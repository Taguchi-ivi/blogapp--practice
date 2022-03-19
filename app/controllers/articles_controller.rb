class ArticlesController < ApplicationController

    # オプションで指定したメソッドを処理する前にset_articleが実行される
    before_action :set_article, only: [:show, :edit, :update]

    # 下記に現状の色んな情報が乗っている
    # http://localhost:3000/rails/info/routes

    def index
        # ルールで書かなくても表示させるようになっている
        # render 'home/index'
        @articles = Article.all
    end

    def show
        # 処理を中断させる
        # binding.pry
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to article_path(@article), notice: '保存できたよ'
        else
            flash.now[:error] = '保存に失敗しました'
            render :new
        end
    end

    def edit
    end

    def update
        if @article.update(article_params)
            redirect_to article_path(@article), notice: '更新できました'
        else
            flash.now[:error] = '更新できませんでした'
            render :edit
        end
    end

    def destroy
        article = Article.find(params[:id])
        # ↓処理が失敗すると止まる !
        article.destroy!
        redirect_to root_path, notice: '削除に成功しました'
    end

    # def about
    # end

    private
        def article_params
            # puts '---------------'
            # puts params
            # puts '---------------'
            params.require(:article).permit(:title, :content)
        end

        def set_article
            # インスタンス変数でないと、他のメソッドからアクセスできない
            @article = Article.find(params[:id])
        end

end
