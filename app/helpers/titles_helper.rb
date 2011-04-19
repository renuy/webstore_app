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
  
  def get_link(caller, title_id)
    case
      when caller.eql?('rs') then upsert_reviews_path(:title_id=>title_id)
      when caller.eql?('rns') then upsert_list_items_path(:title_id=> title_id, :list=>'ORDER')
      when caller.nil?  then upsert_list_items_path(:title_id=> title_id, :list=>'ORDER')
      when caller.blank?  then upsert_list_items_path(:title_id=> title_id, :list=>'ORDER')
    end
  end
end
