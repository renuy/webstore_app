class Payment < ActiveRecord::Base
  CONV_FEE = 3.5

  include ActiveRecord::Transitions

  attr_accessor :Merchant_Id, :Order_Id, :TxnType, :actionID, :Checksum, :Redirect_Url, :workingKey, :Amount, :billing_cust_name,:billing_cust_address
  attr_accessor :billing_cust_country, :billing_cust_state,	:billing_cust_tel, :billing_cust_email, :delivery_cust_name, :delivery_cust_address
  attr_accessor :delivery_cust_state, :delivery_cust_tel, :delivery_cust_notes, :billing_cust_city, :billing_zip_code, :delivery_cust_city, :delivery_zip_code
  attr_accessor :AuthDesc
  validates :order_id, :presence => true  
  validates :amount, :presence => true
  validates :p_mode, :presence => true
  
  
  belongs_to :member
  belongs_to :user  
  validates :member_id, :presence => true
  validates :user_id, :presence => true
  validates :branch_id, :presence => true
  validates :payment_for, :presence => true
  validates :channel, :presence => true
  attr_accessor :months
  before_create :dependent_valid?
  after_save :process_state
  
  def MerchantId
    "M_jbadmin_8205"
  end
  
  def WorkingKey
    "hmuadaclfx2futatbfld06jz4p4k32ee"
  end
  
  def RedirectUrl
    #"http://192.168.1.103:3000/gatewayentry"
    "http://accounts.justbooksclc.com/gatewayentry"
  end
  
  def OrderId
    self.id
  end
  
  def get_checksum
    str = self.MerchantId + "|" + self.OrderId.to_s + "|" + self.amount.to_s + "|" + self.RedirectUrl + "|" + self.WorkingKey;
    self.Checksum = Zlib.adler32(str)
    return self.Checksum.to_s
  end
  
  def verifyChecksum(checkSum, authDesc)
    s_amount =  "%0.2f" % self.amount
    str = self.MerchantId+"|"+self.id.to_s+"|"+s_amount+"|"+authDesc+"|"+self.WorkingKey;
    curr_checksum = Zlib.adler32(str).to_s
    curr_checksum.eql?(checkSum) ? true : false
  end
  
  def calc_conv_fee
    if txn_amount.to_i < 151
      conv_fee = "%0.2f" % (txn_amount * (Payment::CONV_FEE.to_f + 2)/100)
    else
      conv_fee = "%0.2f" % (txn_amount * Payment::CONV_FEE.to_f/100)
    end
    conv_fee
  end  
  
  
  state_machine do
    state :PrePayment # first one is the initial state before sending  for payement
    state :PendingPayment # if sent to payment gateway
    state :ConfirmPayment #
    state :FailedPayment
    state :UnknownPayment
    state :Cancel
    
    event :sent do
      transitions :to => :PendingPayment, :from => [:PrePayment]
    end
    event :paid do
      transitions :to => :ConfirmPayment, :from => [:PendingPayment]
    end
    event :failed do
      transitions :to => :FailedPayment, :from => [:PendingPayment]
    end
    
    event :unknown do
      transitions :to => :UnknownPayment, :from => [:PendingPayment]
    end
    event :cancel do
      transitions :to => :Cancelled, :from => [:PrePayment]
    end
  end
  
  def processEvent(event)
    case 
      when event.eql?('sent') then sent
      when event.eql?('paid') then paid
      when event.eql?('cancel') then cancel
      when event.eql?('failed') then failed
      when event.eql?('unknown') then unknown
    end
  end
  def process_state
    case self.payment_for
          when 'Renewal' 
          case self.state
                when 'ConfirmPayment'
                    renew = Renewal.find(self.order_id)
                    renew.execute!
                    renew.send_mail
                when 'Cancelled'
                    renew = Renewal.find(self.order_id)
                    renew.cancel!
                when 'PendingPayment'
                    renew = Renewal.find(self.order_id)
                    renew.payment_id = self.id
                    renew.save!
                    renew.sent!
                    
          end
          when 'Signup' 
          case self.state
                when 'ConfirmPayment'
                    signup = Signup.find(self.order_id)
                    signup.execute!
                    signup.migrate
                when 'Cancelled'
                    signup = Signup.find(self.order_id)
                    signup.cancel!
                when 'PendingPayment'
                    signup = Signup.find(self.order_id)
                    signup.payment_id = self.id
                    signup.save!
                    signup.sent!
                    
          end
    end
  end
  
  def dependent_valid?
    case self.payment_for
      when 'Renewal' 
        renew = Renewal.find(self.order_id)
        if renew.state.eql?('New') 
          return true 
        else 
          errors.add(:payment_for, "Renewal is "+renew.state)
          return false
        end
      when 'Signup' 
        signup = Signup.find(self.order_id)
        if signup.state.eql?('New') 
          return true 
        else 
          errors.add(:payment_for, "Signup is "+signup.state)
          return false
        end
    end
  end
end
