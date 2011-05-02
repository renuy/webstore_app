class CreateCurrentReads < ActiveRecord::Migration
  def self.up
    create_table :current_reads do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :current_reads
  end
end
