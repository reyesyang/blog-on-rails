class RemoveLicenceFromEvolution < ActiveRecord::Migration
  def self.up
    remove_column :evolutions, :licence
  end

  def self.down
    add_column :evolutions, :licence, :string
  end
end
