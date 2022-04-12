namespace :notification do
    desc '利用者にメールを送付する'

    # arguments => args 英語で引数という意味
    task :send_emails_from_admin, ['msg'] => :environment do |task, args|
        # puts '初めてのRake task'
        # jobを実行させる
        # NotificationFromAdminJob.perform_later('rake task test')
        # puts args['msg']
        msg = args['msg']
        if msg.present?
            NotificationFromAdminJob.perform_later(msg)
        else
            puts '送信できませんでした。メッセージを入力してください。 ex. rails notification:send_emails_from_admin\[こんにちは\]'
        end
    end
end