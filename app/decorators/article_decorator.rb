module ArticleDecorator

    # article.rbから移管
    # viewに関わるものをこちらで定義

    def display_created_at
        # binding.pry
        I18n.l(self.created_at, format: :default)
    end

    def author_name
        user.display_name
    end

    def like_count
        likes.count
    end

end