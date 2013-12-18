class AddTimestampsToTaggings < ActiveRecord::Migration
  def change
    add_column :taggings, :id, :primary_key, first: true 
    add_timestamps :taggings

    reversible do |dir|
      dir.up do
        Tagging.find_each do |tagging|
          article = tagging.article
          tagging.created_at = article.created_at
          tagging.updated_at = article.updated_at
          tagging.save
        end

        Tag.find_each do |tag|
          tag.articles_count = tag.articles.count
          tag.save
        end
      end
    end
  end
end
