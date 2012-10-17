class RenamePasswordDigestToAuthToken < ActiveRecord::Migration
  def up
    rename_column :users, :password_digest, :auth_token
  end

  def down
    rename_column :users, :auth_token, :password_digest
  end
end
