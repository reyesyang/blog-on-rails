# -*- encoding : utf-8 -*-
class RenameTableArticlesTagsToTaggings < ActiveRecord::Migration
  def self.up
		rename_table :articles_tags, :taggings
  end

  def self.down
		rename_table :taggings, :articles_tags
  end
end
