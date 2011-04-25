class AddCardToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders ,:card_id , :integer
  end

  def self.down
  end
end
