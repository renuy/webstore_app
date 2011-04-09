class CreatePendingTitlesForCollections < ActiveRecord::Migration
  def self.up
    create_table :pending_titles_for_collections do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :pending_titles_for_collections
  end
end
