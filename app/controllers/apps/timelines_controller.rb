class Apps::TimelinesController < Apps::ApplicationController
    # Apps::application_controllerで指定しているため不要
    # before_action :authenticate_user!
    
    def show
        # follow指定しているユーザーのIDのみ取得
        user_ids = current_user.followings.pluck(:id)
        # 配列で渡すとor条件になる
        @articles = Article.where(user_id: user_ids)
    end

end