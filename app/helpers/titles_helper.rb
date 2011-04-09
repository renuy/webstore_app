module TitlesHelper
  def titlecount
    100000
  end
  def bookcount
    250000
  end
  def membercount
    30000
  end
  def librarycount
    30
  end
  
  def get_btn_name(caller)
  case 
    when caller.nil?  then 'BORROW'
    when caller.blank?  then 'BORROW'
    when caller.eql?('rs') then 'REVIEW'
    when caller.eql?('rns') then 'BORROW'
    when caller.eql?('rnsd') then 'RETURN'
    end
  end
end
