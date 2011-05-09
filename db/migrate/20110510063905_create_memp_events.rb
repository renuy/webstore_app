class CreateMempEvents < ActiveRecord::Migration
  def self.up
    create_table :memp_events do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :memp_events
  end
end
