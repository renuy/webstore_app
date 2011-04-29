class AddPaymentFields < ActiveRecord::Migration
  def self.up
      add_column :payments, :channel, :string
      add_column :payments, :branch_id, :integer
      add_column :payments, :user_id,  :integer
      add_column :payments, :member_id, :integer
      add_column :payments, :payment_for, :string
      add_column :payments, :txn_amount, :float
  end

  def self.down
  end
end
