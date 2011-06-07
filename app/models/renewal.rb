class Renewal < ActiveRecord::Base
  include ActiveRecord::Transitions
  belongs_to :member
  belongs_to :payment
  belongs_to :card

  validates :member_id, :presence => true  
  validates :amount, :presence => true
  validates :card_id, :presence => true
  validates :months, :presence => true
  before_create :set_defaults
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
      transitions :to => :Executed, :from => [:Paid]
    end
    event :cancel do
      transitions :to => :Cancel, :from => [:New]
    end
  end
  
  def send_mail
    RenewalMailer.renewal_confirmation(self).deliver
  end
  def processEvent(event)
    case 
      when event.eql?('sent') then sent
      when event.eql?('execute') then execute
      when event.eql?('done') then done
      when event.eql?('cancel') then cencel
    end
  end
  
  def set_defaults
    self.reading_fee = self.member.valid_card[0].renewAmount(self.months)
    self.security_deposit = 0
    self.plan_id = self.member.valid_card[0].plan_id
    self.new_plan_id  = self.member.valid_card[0].plan_id
    if self.member.valid_card[0].auto_changeable?
      self.new_plan_id = self.member.valid_card[0].plan.new_plan_id
    end
  end
end
