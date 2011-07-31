class CreateAcknowledges < ActiveRecord::Migration
  def self.up
    create_table :acknowledges do |t|
      t.string :muurl
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :acknowledges
  end
end
