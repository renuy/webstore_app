class CreateSignups < ActiveRecord::Migration
  def self.up
    create_table :signups do |t|
      t.string  :name, :null => false
      t.string  :address, :null => false
      t.integer :mphone
      t.integer :lphone
      t.string  :email, :null => false
      t.string  :referrer_member_id
      t.integer :referrer_cust_id
      t.references :plan, :null => false

      t.references :branch
      
      t.integer :signup_months, :null => false
      
      t.float :security_deposit, :null => false
      t.float :registration_fee, :null => false
      t.float :reading_fee, :null => false
      t.float :discount, :null => false # this is called adjusted_amt
      t.float :advance_amt, :null => false # in case paid in excess
      
      t.float :paid_amt, :null => false # actually paid
      t.float :overdue_amt, :null => false # in case paid less than expected
      
      
      t.integer :payment_mode, :null => false
      t.string :payment_ref, :null => false
      
      t.string :membership_no
      t.string :application_no
      
      t.string :employee_no

      t.integer :created_by, :null => false
      t.integer :modified_by, :null => false
      
      t.string :flag_migrated, :size => 2, :default => 'U'
      t.date :start_date, :null => false
      t.date :expiry_date, :null => false
      t.string :remarks
      t.string :state
      
      t.float :coupon_amt
      
      t.string :coupon_no
      t.integer  :coupon_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :signups
  end
end
