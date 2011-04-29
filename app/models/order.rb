class Order < ActiveRecord::Base
  include ActiveRecord::Transitions

  has_many :items
  belongs_to :member
  belongs_to :user  
  validates :member_id, :presence => true
  validates :user_id, :presence => true
  validates :card_id, :presence => true
  validates :branch_id, :presence => true
  validates :order_for, :presence => true
  validates :channel, :presence => true
  attr_accessor :months
  
  before_create :set_new_state_and_charge
  after_create :set_dependent
  before_save :process_state
  state_machine do
    state :PrePayment # first one is the initial state before sending  for payement
    state :PendingPayment # if sent to payment gateway
    state :ConfirmPayment #
    state :Executed
    state :Completed
    state :Cancel
    
    event :sent do
      transitions :to => :PendingPayment, :from => [:PrePayment]
    end
    event :paid do
      transitions :to => :ConfirmPayment, :from => [:PrePayment, :PendingPayment]
    end
    event :execute do
      transitions :to => :Executed, :from => [:ConfirmPayment, :PendingPayment,:PrePayment]
    end
    event :complete do
      transitions :to => :Completed, :from => [:Executed]
    end
    event :cancel do
      transitions :to => :Cancelled, :from => [:PrePayment]
    end
  end
  
  def process_state
    case self.order_for
      when 'ren' 
        case self.state
          when 'ConfirmPayment'
              renew = Renewal.find_by_order_id(self.id)
              renew.execute!
          when 'Cancelled'
              renew = Renewal.find_by_order_id(self.id)
              renew.cancel!
        end
    end
  end
  
  def set_new_state_and_charge
    self.state = 'PrePayment'
    self.charge = self.amount > 0 ?  "YES" : "NO"
  end
  
  def set_dependent
    case self.order_for
      when 'ren' 
        renew = Renewal.new
        renew.order_id = self.id
        renew.months=self.months.to_i
        renew.member_id = self.member_id
        renew.card_id = member.valid_card[0].card_id
        renew.from_date = member.valid_card[0].expiry_date
        renew.to_date = member.valid_card[0].newExpiry(self.months.to_i)
        renew.amount = member.valid_card[0].renewAmount(self.months.to_i)
        renew.state="New"
        renew.save!
    end
  end
  def processEvent(event)
    case 
      when event.eql?('sent') then sent
      when event.eql?('paid') then paid
      when event.eql?('execute') then execute
      when event.eql?('complete') then complete
      when event.eql?('cancel') then cancel
    end
  end
  
  end
