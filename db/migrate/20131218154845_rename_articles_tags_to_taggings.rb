class RenameArticlesTagsToTaggings < ActiveRecord::Migration
  def change
    rename_table :articles_tags, :taggings
  end
end
