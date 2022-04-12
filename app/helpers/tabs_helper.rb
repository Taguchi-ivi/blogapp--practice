module TabsHelper
    def add_active_class(path)
        # topページを開くとatciveクラスが剥がされる
        path = path.split('?').first
        'active' if current_page?(path)
    end
end