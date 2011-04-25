class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.references :order
      t.string :state #reverse/original
      t.integer :orig_id
      t.float :amount
      t.string :mode
      t.string :details
      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
