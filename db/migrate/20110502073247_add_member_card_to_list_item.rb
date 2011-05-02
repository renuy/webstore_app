class AddMemberCardToListItem < ActiveRecord::Migration
  def self.up
    add_column :list_items, :card_id , :string
  end

  def self.down
  end
end
