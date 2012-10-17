class RemoveEnglishTitleFromArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :english_title
  end

  def down
    add_column :articles, :english_title, :string
  end
end
