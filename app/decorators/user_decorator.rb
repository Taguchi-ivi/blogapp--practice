# frozen_string_literal: true

module UserDecorator

    # user.rbから移管
    # viewに関わるものをこちらで定義

    def display_name
        # self.email.split('@').first
        # profileがnilだった場合エラーになる
        # profile.nickname || self.email.split('@').first
        # if profile && profile.nickname
        #   profile.nickname
        # else
        #   self.email.split('@').first
        # end
        # ↓
        # ぼっち演算子
        profile&.nickname || self.email.split('@').first
    end

    # current_user =>deviseのやつとdecoratorの相性が悪い
    def avatar_image
        if profile&.avatar&.attached?
            profile.avatar
        else
            'default-avatar.png'
        end
    end

end
