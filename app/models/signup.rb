class Signup < ActiveRecord::Base
  include ActiveRecord::Transitions
  
  PAYMENT_MODES = {
    :cash   => 1,
    :check  => 2, 
    :card   => 3
  }  
  
  attr_accessor :check_no, :card_no
  attr_accessible :id, :name, :address, :mphone, :lphone, :email, :referrer_member_id, 
    :employee_no, :plan_id, :branch_id, :signup_months, :payment_mode, :membership_no, 
    :application_no, :coupon_no, :coupon_id, :coupon_amt, :paid_amt, :company_id, 
    :info_source_id, :flag_reversed, :reversal_reason_id, :state
  
  belongs_to :user, :foreign_key => 'created_by'
  belongs_to :user, :foreign_key => 'modified_by'
  belongs_to :plan
  belongs_to :branch
  belongs_to :company
  
  
  validates :name, :presence => true, :length => { :minimum => 2, :maximum => 100 }
  validates :address, :presence => true, :length => { :minimum => 2, :maximum => 100 }
  validates :branch_id, :presence => true
  validates :referrer_member_id, :length => { :maximum => 7 }
  validates :employee_no, :length => { :maximum => 10 }
  validates :membership_no, :presence => true, :length => { :is => 11 }  
  validates :paid_amt, :presence => true, :numericality => { :greater_than => 0 }  
# validates :application_no, :presence => true, :uniqueness => true, :length => { :maximum => 10 }
  validates :payment_mode, :presence => true, :numericality => {:greater_than => 0, :less_than => 4 }
  validates :email, :presence => true
  validates :info_source_id, :presence => { :message => " Please select - How did you come to know about us ?" }
  validate :payment_ref_should_not_be_blank
  validate :atleast_one_phone_number_required
  validate :coupon_no_should_not_be_blank
  validate :paid_amt_greater_than_bill_amt
  validate :membership_no_should_be_unique
  validate :company_and_employee_not_blank
  
  validate :referrer_existence_validation
  validate :membership_dup_validation
  validate :paid_amt_only_rupee_allowed
  validate :email_dup_validation
  validate :validate_membership_format

  before_save :set_defaults
  before_create :company_and_employee_uniqness
  #after_create { generateSignupEvent }
  #after_update { generateNMReversalEvent }
    
  state_machine do
    state :New # first one is the initial state before sending  for payement
    state :PendingPay # if sent to payment gateway
    state :Paid # if sent to payment gateway
    state :Executed
    state :Cancel
    
    event :sent do
      transitions :to => :PendingPay, :from => [:New]
    end
    event :execute do
      transitions :to => :Paid, :from => [:PendingPay]
    end
    event :done do
      transitions :to => :Executed, :from => [:Paid] #, :on_transition => :do_migrate
    end
    event :cancel do
      transitions :to => :Cancel, :from => [:New]
    end
  end
  
  def processEvent(event)
    case 
      when event.eql?('sent') then sent
      when event.eql?('execute') then execute
      when event.eql?('done') then done
      when event.eql?('cancel') then cencel
    end
  end

  def coupon_no_should_not_be_blank
      if coupon_no.blank?
        errors.add(:coupon_no, "should not be blank") unless coupon_id.nil?
      end
  end
  
  def payment_ref_should_not_be_blank
    if payment_ref.blank? 
      errors.add(:check_no, "should not be blank") if payment_mode == Signup::PAYMENT_MODES[:check]
      errors.add(:card_no, "should not be blank") if payment_mode == Signup::PAYMENT_MODES[:card]
    end
  end
  
  def atleast_one_phone_number_required
    if mphone.blank? && lphone.blank?
      errors.add(:mphone, "is required")
    end
    unless lphone.blank?
      begin
        errors.add(:lphone, "is more than 10 digits") if lphone.to_s.length > 10
        errors.add(:lphone, "is less than 8 digits") if lphone.to_s.length < 8
      end
    end
    unless mphone.blank?
      begin
        errors.add(:mphone, "should be 10 digits") if mphone.to_s.length != 10
      end
    end
  end

  def paid_amt_greater_than_bill_amt
    unless paid_amt.blank?
      plan = Plan.find(plan_id)
      if (plan.subscription)
        bill_amt = plan.sec_dep + plan.registration_fee+ plan.renewAmount(signup_months)
        errors.add(:paid_amt, "is more than Bill Amount") if paid_amt.to_d > bill_amt.to_d
      else
        bill_amt = plan.ppb_amount(self.signup_months) + plan.registration_fee
        errors.add(:paid_amt, "is more than Bill Amount") if paid_amt.to_d > bill_amt.to_d
      end
    end
  end

  def membership_no_should_be_unique
    signup = Signup.find_by_membership_no_and_flag_reversed(membership_no, 'N')

    unless signup.nil?
      errors.add(:membership_no, "has already been taken") unless id == signup.id
    end
  end

  def company_and_employee_not_blank
      plan = Plan.find(plan_id)

      if employee_no.blank?
        errors.add(:employee_no, "can't be blank for corporate plan!") if plan.plan_type == "C"
      end

      if company_id.blank?
        errors.add(:company_id, "name can't be blank for corporate plan!") if plan.plan_type == "C"
      end
  end

  def company_and_employee_uniqness
        plan = Plan.find(plan_id)
          signup = Signup.find(:all, :conditions=> ["company_id=? and employee_no=? and state in (?)", company_id, employee_no,['Paid', 'Executed']])
           unless signup.blank?
           errors.add(:company_id, " and employee is already a member!") if plan.plan_type == "C"
           return false
           end
  end

  def referrer_existence_validation
   unless referrer_member_id.blank?
      card= Card.find_all_by_membership_no(referrer_member_id)
       if card.blank?
        errors.add(:referrer_member_id, " is not valid!")
       end
  end
 end
 
  def membership_dup_validation
    card= Card.find_all_by_card_id(membership_no)

    unless flag_reversed == 'Y'
      unless card.blank?
        errors.add(:membership_no, " is already in use!")
      end
    end
  end

  def paid_amt_only_rupee_allowed
    if paid_amt != paid_amt.to_i
      errors.add(:paid_amt, " cannot have paise, Please enter Paid Amt in rupees") unless paid_amt.blank?
    end
  end
  
  def email_dup_validation
       

  end 
  
  def validate_membership_format
  
    reg = /^T[[\d]]{10}$/

    if !(reg.match(membership_no))
     errors.add(:base, "Membership number format is wrong, it should be 'T' followed by 6 digits")
    end

  end


  def decode_frequency
      case self.plan.frequency.upcase
      when 'M' then
        'month'
      when 'Y' then
        'year'
      else
      'book per month'
      end
  end

  def migrate
    if self.state.eql?('Paid')
      migrate_signup
      self.done!
      SignupMailer.registration_confirmation(self).deliver
    end
    
  end
  
  def migrate_signup
    
    memp_signup = MempSignup.new
    memp_signup.name = self.name
    memp_signup.address = self.address
    memp_signup.mphone = self.mphone
    memp_signup.lphone = self.lphone
    memp_signup.email = self.email 
    memp_signup.referrer_member_id = self.referrer_member_id
    memp_signup.referrer_cust_id = self.referrer_cust_id
    memp_signup.plan_id = self.plan_id
    memp_signup.branch_id = self.branch_id
    memp_signup.signup_months = self.signup_months
    memp_signup.security_deposit = self.security_deposit
    memp_signup.registration_fee = self.registration_fee
    memp_signup.reading_fee = self.reading_fee
    memp_signup.discount = self.discount
    memp_signup.advance_amt = self.advance_amt
    memp_signup.paid_amt = self.paid_amt
    memp_signup.overdue_amt = self.overdue_amt
    memp_signup.payment_mode = self.payment_mode
    memp_signup.payment_ref = self.payment_ref
    memp_signup.membership_no = self.membership_no
    memp_signup.application_no = self.application_no
    memp_signup.employee_no = self.employee_no
    memp_signup.created_by = 1000
    memp_signup.modified_by = 1000
    memp_signup.flag_migrated = self.flag_migrated
    memp_signup.start_date = self.start_date
    memp_signup.expiry_date = self.expiry_date
    memp_signup.remarks = self.remarks
    memp_signup.created_at = self.created_at
    memp_signup.updated_at = self.updated_at
    memp_signup.coupon_amt = self.coupon_amt
    memp_signup.coupon_no = self.coupon_no
    memp_signup.coupon_id = self.coupon_id
    memp_signup.flag_reversed = self.flag_reversed
    memp_signup.company_id = self.company_id
    memp_signup.info_source_id = self.info_source_id
    memp_signup.reversal_reason_id = self.reversal_reason_id
    memp_signup.created_in = 801
    memp_signup.modified_in = 801
    memp_signup.order_id = self.payment_id
    if !memp_signup.save!
      logger.debug'failed to save'
    end
      logger.debug' saved'
  end
  private 
  
  def set_defaults
    plan = Plan.find(plan_id)
    
    self.referrer_cust_id = nil
    self.application_no = '1'
    
    unless self.coupon_id.nil?
      coupon = plan.coupons.find(self.coupon_id)
      self.discount = coupon.discount
      self.coupon_amt = coupon.amount
    else
      self.discount = 0
      self.coupon_amt = 0
      self.coupon_no = nil
    end

    # these values are possibly allowed to be changed during sign-up
    # dont have time to do this
    if plan.subscription
      self.security_deposit = plan.sec_dep
      self.registration_fee = plan.registration_fee
      self.reading_fee = plan.renewAmount(self.signup_months)
    else
      self.security_deposit = plan.ppb_sec_dep(self.signup_months)
      self.registration_fee = plan.registration_fee
      self.reading_fee = plan.ppb_read_fee(self.signup_months)
    end
    self.advance_amt = 0    
    self.overdue_amt = 0

    #part payment starts
    bill_amt = self.security_deposit + self.registration_fee + self.reading_fee - (self.discount + self.coupon_amt)    
    actual_paid_amt = self.paid_amt
    
    if bill_amt > actual_paid_amt
      self.overdue_amt = bill_amt - actual_paid_amt
    end
    #part payment ends    
    
    self.start_date = Time.zone.today
    if plan.subscription
      self.expiry_date = self.start_date.months_since(self.signup_months)
    else
      self.expiry_date = self.start_date.months_since(100)
    end
  end
  
  
end
