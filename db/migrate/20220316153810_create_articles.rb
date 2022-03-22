class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      # 空欄を許容しない user_id => null: false
      t.references :user, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end
