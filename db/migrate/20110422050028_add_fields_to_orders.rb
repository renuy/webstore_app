class AddFieldsToOrders < ActiveRecord::Migration
  def self.up

    add_column :orders ,:branch_id , :integer 
    add_column :orders ,:state , :string 
    add_column :orders ,:order_for , :string 
    add_column :orders ,:description , :string
    add_column :orders ,:user_id , :integer
    add_column :orders ,:channel , :string
  end

  def self.down
  end
end
