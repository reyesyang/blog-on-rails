class RemoveArticleIdFromTags < ActiveRecord::Migration
  def self.up
    remove_column :tags, :article_id
  end

  def self.down
    add_column :tags, :article_id, :integer
  end
end
