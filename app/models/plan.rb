class Plan < ActiveRecord::Base

  def renewable?
    (self.allow_renewal.upcase.eql?('NO')  or self.frequency.upcase.eql?("N") or  self.expired? ) ? false : true
  end
  
  def expired?
    (!self.expiry_date.nil? and  self.expiry_date < Time.zone.today )? true : false
  end

  def renewMonthsArr
    renew_for =[]
    
    if self.allow_renewal.upcase.eql?('NO') 
      return renew_for
    end
    
    case
      when self.frequency.upcase.eql?("M")
        if self.allow_renewal.upcase.eql?('YES') 
          renew_for << 1
          renew_for << 3
        end
        renew_for << 6
        renew_for << 12
      when self.frequency.upcase.eql?("H")
        renew_for << 6
        renew_for << 12
      when self.frequency.upcase.eql?("Y")
        renew_for << 12
        renew_for << 24
    end
    
    return renew_for
  end
  
end
