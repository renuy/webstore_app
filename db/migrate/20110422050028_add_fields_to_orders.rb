class AddFieldsToOrders < ActiveRecord::Migration
  def self.up
      t.references :branch
      t.string :state
      t.string :order_for
      t.string :coment
      t.reference :user
      t.string :channel
  end

  def self.down
  end
end
