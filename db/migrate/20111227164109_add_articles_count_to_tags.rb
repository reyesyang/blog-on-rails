class AddArticlesCountToTags < ActiveRecord::Migration
  def change
    add_column :tags, :articles_count, :integer, :default => 0
  end
end
