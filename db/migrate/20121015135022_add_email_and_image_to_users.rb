class AddEmailAndImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :image_url, :string
  end
end
