class ApplicationController < ActionController::Base

    before_action :set_locale

    def current_user
        ActiveDecorator::Decorator.instance.decorate(super) if super.present?
        super
    end

    #  必ず実行されるメソッド
    def default_url_options
        { locale: I18n.locale }
    end

    private
        def set_locale
            # 設定言語変更する 全てのアクションで適用される
            # 値が存在しなかったら初期設定 config/application.rbの値が取得される
            I18n.locale = params[:locale] || I18n.default_locale
        end
end
