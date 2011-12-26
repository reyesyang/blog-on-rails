class RemoveSummaryFromArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :summary
  end

  def down
    add_column :articles, :summary, :text
  end
end
