class FavoritesController < ApplicationController
    before_action :authenticate_user!

    def index
        # userモデルにて指定したfavorite_articles
        @articles = current_user.favorite_articles
    end

end