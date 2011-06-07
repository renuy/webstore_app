class AddPlanAndNewPlanToRenewals < ActiveRecord::Migration
  def self.up
    add_column :renewals ,:plan_id , :integer 
    add_column :renewals ,:new_plan_id , :integer 
  end

  def self.down
  end
end
