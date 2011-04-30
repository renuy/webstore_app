class CreateFavourites < ActiveRecord::Migration
  def self.up
    create_table :favourites do |t|
      t.references :user
      t.string :favourite
      t.integer :item_id
      t.integer :rank
      
    end
  end

  def self.down
    drop_table :favourites
  end
end
