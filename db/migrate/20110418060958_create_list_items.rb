class CreateListItems < ActiveRecord::Migration
  def self.up
    create_table :list_items do |t|
      t.references :book_list
      t.references :title
      t.references :member
      t.references :shelf
      t.timestamps
    end
  end

  def self.down
    drop_table :list_items
  end
end
