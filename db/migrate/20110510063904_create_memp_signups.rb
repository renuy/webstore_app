class CreateMempSignups < ActiveRecord::Migration
  def self.up
    create_table :memp_signups do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :memp_signups
  end
end
