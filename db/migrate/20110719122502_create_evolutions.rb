class CreateEvolutions < ActiveRecord::Migration
  def self.up
    create_table :evolutions do |t|
      t.string :licence
      t.text :change

      t.timestamps
    end
  end

  def self.down
    drop_table :evolutions
  end
end
