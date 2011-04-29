class Renewal < ActiveRecord::Migration
  def self.up
    add_column :renewals, :member_id, :integer
    add_column :renewals, :amount, :float
    add_column :renewals, :state, :string
    modify_column :renewals, :card_id, :string  
    add_column :renewals, :payment_id, :integer
    
  end

  def self.down
  end
end
