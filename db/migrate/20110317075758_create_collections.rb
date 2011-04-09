class CreateCollections < ActiveRecord::Migration
  def self.up
    create_table :collections do |t|
      t.references :titles
      t.references :series
      t.references :collection_name
      t.timestamps
    end
  end

  def self.down
    drop_table :collections
  end
end
