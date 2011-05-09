class AddInfoSourceToSignups < ActiveRecord::Migration
  def self.up
    add_column :signups, :flg_reversed, :string
    add_column :signups, company_id, :integer
    add_column :signups, reversal_reason_id, :integer
    
  end

  def self.down
    
  end
end
