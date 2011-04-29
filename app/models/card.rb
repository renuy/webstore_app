class Card < ActiveRecord::Base
belongs_to :member
belongs_to :plan

  def isLost?
    ch = CardHistory.find_by_card_id(self.card_id)
    ch.nil? ? false :true
  end
  
  def inWaiver?
    self.plan_id == 26  ? true : false
  end
  
  def renewable?
      (self.inWaiver? or !self.plan.renewable? ) ? false : true
  end
  
  def renewAmount(months)
    renew_amount = 0
    if self.renewable?
      renew_amount = self.plan.renewAmount(months.to_i)
    end
  end
  
  def newExpiry(months)
    new_expiry = self.expiry_date
    if (self.renewable?  and self.plan.renewMonthsArr.include?(months.to_i))
      new_expiry = self.expiry_date.advance(:months=> months.to_i)
    end
    
    return new_expiry
  end
  
end
