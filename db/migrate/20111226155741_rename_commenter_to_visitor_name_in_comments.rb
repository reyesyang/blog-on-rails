# -*- encoding : utf-8 -*-
class RenameCommenterToVisitorNameInComments < ActiveRecord::Migration
  def change
    rename_column :comments, :commenter, :visitor_name
  end
end
