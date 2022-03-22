# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
    # presence => 存在有無 ブランクだとエラー
    # length => 長さ, minimumは最低でも2文字ないとエラー, maximuumは100以下でないとエラー
    # uniqueness => 一意 同じものがないようにする場合はtrue, すでに存在する場合はエラー
    # format => 特定の表現か確認,
    validates :title, presence: true
    validates :title, length: { minimum: 2, maximum: 100 }
    validates :title, format: { with: /\A(?!\@)/ }

    validates :content, presence: true
    validates :content, length: { minimum: 10}
    validates :content, uniqueness: true

    # 独自のバリデーション
    validate :validate_title_content_length

    # belongs_toは単数系でuser
    belongs_to :user
    # 記事一つに対して複数のコメントなので、commentsと複数形に,記事が消えたらコメントも削除
    has_many :comments, dependent: :destroy

    def display_created_at
        # binding.pry
        I18n.l(self.created_at, format: :default)
    end

    def author_name
        user.display_name
    end

    private

        def validate_title_content_length
            char_count = self.title.length + self.content.length
            unless char_count > 100
                errors.add(:content, '100文字以上で!')
            end
        end

end
