class AddInfoSourceId < ActiveRecord::Migration
  def self.up
    add_column :signups, :info_source_id, :integer
  end

  def self.down
  end
end
