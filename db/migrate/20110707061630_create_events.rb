class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :branch_name
      t.string :guest_name
      t.string :email
      t.string :mphone
      t.string :message

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
