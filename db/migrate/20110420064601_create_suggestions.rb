class CreateSuggestions < ActiveRecord::Migration
  def self.up
    create_table :suggestions do |t|
      t.references :title
      t.references :by
      t.references :to
      t.timestamps
    end
  end

  def self.down
    drop_table :suggestions
  end
end
