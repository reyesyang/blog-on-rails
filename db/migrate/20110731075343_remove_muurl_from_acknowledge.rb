# -*- encoding : utf-8 -*-
class RemoveMuurlFromAcknowledge < ActiveRecord::Migration
  def self.up
    remove_column :acknowledges, :muurl
  end

  def self.down
    add_column :acknowledges, :muurl, :string
  end
end
