class ProfilesController < ApplicationController

    # ログインしていないと対応できないように!!
    before_action :authenticate_user!, 

    def show
        @profile = current_user.profile
    end

    def edit
        # 空欄だったらbuild,空欄ではない場合は値を渡す
        # if current_user.profile.present?
        #     @profile = current_user.profile
        # else
        #     # has_oneの場合の書き方 .articles.buildではなく下記の書き方をする
        #     @profile = current_user.build_profile
        # end
        # @profile = current_user.profile || current_user.build_profile
        # user.rbにメソッド作成 => prepare_profile
        @profile = current_user.prepare_profile
    end

    def update
        @profile = current_user.prepare_profile
        @profile.assign_attributes(profile_params)
        if @profile.save
            redirect_to profile_path, notice: 'プロフィールを更新'
        else
            flash.now[:error] = '更新できませんでした'
            render :edit
        end
    end

    private
        def profile_params
            params.require(:profile).permit(
                :nickname,
                :introduction,
                :gender,
                :birthday,
                :subscribed,
                :avatar
            )
        end

end
