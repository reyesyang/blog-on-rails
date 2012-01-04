# -*- encoding : utf-8 -*-
class AddVersionToEvolutions < ActiveRecord::Migration
  def self.up
    add_column :evolutions, :version, :string
  end

  def self.down
    remove_column :evolutions, :version
  end
end
