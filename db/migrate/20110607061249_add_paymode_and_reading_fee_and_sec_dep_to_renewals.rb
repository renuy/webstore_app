class AddPaymodeAndReadingFeeAndSecDepToRenewals < ActiveRecord::Migration
  def self.up
    add_column :renewals ,:pay_mode , :integer 
    add_column :renewals ,:reading_fee , :float 
    add_column :renewals ,:security_deposit , :float 

  end

  def self.down
  end
end
