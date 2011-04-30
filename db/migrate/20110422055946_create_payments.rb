class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.string :state #reverse/original
      t.integer :orig_id
      t.float :amount
      t.string :p_mode
      t.string :details
      t.float :fee
      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
