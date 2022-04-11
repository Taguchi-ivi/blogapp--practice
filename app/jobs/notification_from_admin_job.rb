class NotificationFromAdminJob < ApplicationJob
    queue_as :default

    # jobでは絶対に書かないといけない
    def perform(msg)

        # 登録者全員に非同期処理によりメールを送信
        User.all.each do |user|
            NotificationFromAdminMailer.notify(user, msg).deliver_later
        end
    end
end