class RenameHasedPasswordAndRemoveSaltInUser < ActiveRecord::Migration
  def up
    rename_column :users, :hashed_password, :password_digest
    remove_column :users, :salt
  end

  def down
    rename_column :users, :password_digest, :hashed_password
    add_column :users, :salt, :string
  end
end
