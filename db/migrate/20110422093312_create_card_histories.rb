class CreateCardHistories < ActiveRecord::Migration
  def self.up
    create_table :card_histories do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :card_histories
  end
end
