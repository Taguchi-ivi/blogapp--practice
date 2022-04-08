# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  
  # userは記事をたくさんん持っている 複数形なのでarticles
  # usesrがいなくなったら全て記事も削除 dependet destroy
  has_many :articles, dependent: :destroy

  # 一つなので複数形にしない
  has_one :profile, dependent: :destroy

  # 複数存在するので複数形
  has_many :likes, dependent: :destroy

  # 中間TBLを経由して値を取得する=> through, favorite_articlesはarticleのことを言っている=>source
  has_many :favorite_articles, through: :likes, source: :article

  # following => 自分が誰かにフォローしている, フォロ-したuserのidが入る
  # follower  => 自分が誰かをフォローしていた場合、自分がfollowerになる, フォローしたcurrent_userのidが入る
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following

  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower


  # delegate allow_nil: trueによって、存在しなくてもエラーにならない
  delegate :birthday, :age, :gender, to: :profile, allow_nil: true

  def has_written?(article)
    articles.exists?(id: article.id)
  end

  def has_liked?(article)
      likes.exists?(article_id: article.id)
  end
  
  # delegateによって birthday,genderメソッドが不要になる
  # def birthday
  #   profile&.birthday
  # end

  # def gender
  #   profile&.gender
  # end

  # 誰かをフォローする
  def follow!(user)

    user_id = get_user_id(user)
    following_relationships.create!(following_id: user_id)
  end

  def unfollow!(user)

    user_id = get_user_id(user)
    relation = following_relationships.find_by!(following_id: user_id)
    relation.destroy!
  end

  # フォローしているか確認する
  # current_user.has_followed?(user.second)
  def has_followed?(user)
    following_relationships.exists?(following_id: user.id)
  end
  
  def prepare_profile
    profile || build_profile
  end

  private

    # Userクラスのインスタンスか判定して処理を分ける,paramsからの値はインスタンスではなく数字のみなので
    def get_user_id(user)
      if user.is_a?(User)
        user.id
      else
        user
      end
    end

end
