class AddFieldToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders ,:charge , :string
  end

  def self.down
  end
end
