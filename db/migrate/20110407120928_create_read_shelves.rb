class CreateReadShelves < ActiveRecord::Migration
  def self.up
    create_table :read_shelves do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :read_shelves
  end
end
