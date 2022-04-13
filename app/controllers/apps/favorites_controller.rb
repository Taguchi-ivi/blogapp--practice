class Apps::FavoritesController < Apps::ApplicationController
    # Apps::application_controllerで指定しているため不要
    # before_action :authenticate_user!

    def index
        # userモデルにて指定したfavorite_articles
        @articles = current_user.favorite_articles
    end

end