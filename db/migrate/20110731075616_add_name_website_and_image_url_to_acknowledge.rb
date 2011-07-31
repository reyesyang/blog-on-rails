class AddNameWebsiteAndImageUrlToAcknowledge < ActiveRecord::Migration
  def self.up
    add_column :acknowledges, :name, :string
    add_column :acknowledges, :website, :string
    add_column :acknowledges, :image_url, :string
  end

  def self.down
    remove_column :acknowledges, :image_url
    remove_column :acknowledges, :website
    remove_column :acknowledges, :name
  end
end
