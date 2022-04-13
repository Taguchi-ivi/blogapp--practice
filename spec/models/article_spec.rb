require 'rails_helper'

RSpec.describe Article, type: :model do
  # 不要な初期値をコメントアウト
  # pending "add some examples to (or delete) #{__FILE__}"
  
  # 処理を途中で止めることも可能
  # binding.pry

  # let!(:user) do
  #   User.create!({
  #     email: 'testtest@examle.com',
  #     password: 'password'
  #   })
  # end
  # factory_botで書き換え
  # emailのみ指定することも可能
  # let!(:user) { create(:user, email: 'test@test.com') }
  let!(:user) { create(:user) }

  context 'タイトルと内容が入力されている場合' do

    # let!(:article) do
    #   user.articles.build({
    #     title: Faker::Lorem.characters(number: 10) ,
    #     content: Faker::Lorem.characters(number: 300)
    #   })
    # end
    # factorybotに書き換え
    let!(:article) { build(:article, user: user) }
    
    # letを使う場合はbefore使わない
    # before do
    #   user = User.create!({
    #     email: 'testtest@examle.com',
    #     password: 'password'
    #   })
    #   @article = user.articles.build({
    #     title: Faker::Lorem.characters(number: 10) ,
    #     content: Faker::Lorem.characters(number: 300)
    #   })
    # end

    it '記事を保存できる' do
      expect(article).to be_valid
    end
  end

  context 'タイトルの文字が一文字の場合' do
    
    # let!(:article) do
    #   user.articles.create({
    #     title: Faker::Lorem.characters(number: 1),
    #     content: Faker::Lorem.characters(number: 300)
    #   })
    # factorybotに書き換え,createを使うと create!と同じ意味になり処理を実行できないので
    # beforeで保存処理を実施
    let!(:article) { build(:article, title: Faker::Lorem.characters(number: 1), user: user) }

    before do
      article.save
    end

    it '記事を保存できない' do
      expect(article.errors.messages[:title][0]).to eq('は2文字以上で入力してください')
    end
  end
end


