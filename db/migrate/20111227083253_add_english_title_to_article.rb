class AddEnglishTitleToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :english_title, :string
  end
end
