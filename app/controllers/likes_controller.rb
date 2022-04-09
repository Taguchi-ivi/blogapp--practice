
class LikesController < ApplicationController
    before_action :authenticate_user!

    def show
        article = Article.find(params[:article_id])
        like_status = current_user.has_liked?(article)
        # js流にhasLiked jsonだけを返した,データのみを返したい場合の記載
        render json: { hasLiked: like_status}
    end

    def create
        article = Article.find(params[:article_id])
        article.likes.create!(user_id: current_user.id)
        # APIによる非同期処理によって遷移不要に
        # redirect_to article_path(article)
        render json: { status: 'ok' }
    end

    def destroy
        article = Article.find(params[:article_id])
        like =article.likes.find_by!(user_id: current_user.id)
        like.destroy!
        # APIによる非同期処理によって遷移不要に
        # redirect_to article_path(article)
        render json: { status: 'ok' }
    end


end