class CreateCollectionNames < ActiveRecord::Migration
  def self.up
    create_table :collection_names do |t|
      t.string :name
      t.string :serialized
      t.timestamps
    end
  end

  def self.down
    drop_table :collection_names
  end
end
