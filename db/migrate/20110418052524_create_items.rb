class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.references :order
      t.references :title
      t.string  :state
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
