class RenameTableTaggingsToArticlesTags < ActiveRecord::Migration
  def self.up
    rename_table :taggings, :articles_tags
  end

  def self.down
    rename_table :articles_tags, :taggings
  end
end
