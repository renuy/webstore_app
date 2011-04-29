class AddFieldToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders ,:charge , :string
    add_column :orders ,:amount , :float
    modify_column orders, :card_id, :string 
  end

  def self.down
  end
end
