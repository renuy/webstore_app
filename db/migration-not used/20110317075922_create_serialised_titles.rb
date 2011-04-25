class CreateSerialisedTitles < ActiveRecord::Migration
  def self.up
    create_table :serialised_titles do |t|
      t.references :titles
      t.references :series
      t.timestamps
    end
  end

  def self.down
    drop_table :serialised_titles
  end
end
