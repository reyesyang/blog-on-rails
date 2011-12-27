class AddVisitorEmailAndVisitorWebsiteToComments < ActiveRecord::Migration
  def change
    add_column :comments, :visitor_email, :string
    add_column :comments, :visitor_website, :string
  end
end
