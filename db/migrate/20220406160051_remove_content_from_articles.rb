class RemoveContentFromArticles < ActiveRecord::Migration[6.0]
  # up,downどちらにも対応できる
  def change
    remove_column :articles, :content, :text
  end

  # up => migrate 
  # def up
  #   remove_column :articles, :content
  # end

  # down => rollback
  # def def down 
  #   add_column :articles, :content, :text
  # end
end
