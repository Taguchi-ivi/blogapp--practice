class Api::CommentsController < Api::ApplicationController

    # jsonにより非同期処理を行うことになったので、不要になる
    # def new
    #     article = Article.find(params[:article_id])
    #     @comment = article.comments.build
    # end

    def index
        article = Article.find(params[:article_id])
        comments = article.comments
        render json: comments
    end

    def create
        article = Article.find(params[:article_id])
        @comment = article.comments.build(comment_params)
        @comment.save!
        # 非同期処理により不要に
        # if @comment.save
        #     redirect_to article_path(article), notice: 'コメントを追加'
        # else
        #     flash.now[:error] = '更新できませんでした'
        #     render :new
        # end
        render json: @comment
    end


    private

    def comment_params
        params.require(:comment).permit(:content)
    end

end