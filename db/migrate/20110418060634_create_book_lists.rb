class CreateBookLists < ActiveRecord::Migration
  def self.up
    create_table :book_lists do |t|
      t.references :user
      t.string :category
      t.timestamps
    end
  end

  def self.down
    drop_table :book_lists
  end
end
