class CreateRenewals < ActiveRecord::Migration
  def self.up
    create_table :renewals do |t|
      t.integer :months #reverse/original
      t.date :from_date
      t.date :to_date
      t.references :card
      t.timestamps
    end
  end

  def self.down
    drop_table :renewals
  end
end
