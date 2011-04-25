class Order < ActiveRecord::Base
  include ActiveRecord::Transitions

  has_many :items
  belongs_to :member
  
  validates :member_id, :presence => true
  validates :card_id, :presence => true
  validates :branch_id, :presence => true
  validates :order_for, :presence => true
  validates :channel, :presence => true
  
  before_create :set_state
  before_save :validate_state
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
  
  def validate_state
      return true
  end
  
  def set_new_state
    self.state = 'PrePayment'
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
