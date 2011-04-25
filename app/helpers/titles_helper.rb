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
    when caller.eql?('READ') then 'REVIEW'
    when caller.eql?('BOOKMARKED') then 'BORROW'
    when caller.eql?('READING') then 'RETURN'
    end
  end
  
  def get_link(caller, title_id)
    case
      when caller.eql?('READ') then upsert_reviews_path(:title_id=>title_id)
      when caller.eql?('BOOKMARKED') then upsert_list_items_path(:title_id=> title_id, :list=>'ORDER')
      when caller.nil?  then upsert_list_items_path(:title_id=> title_id, :list=>'ORDER')
      when caller.blank?  then upsert_list_items_path(:title_id=> title_id, :list=>'ORDER')
    end
  end
  
  def isParentLogin?()
    (user_signed_in? and current_user.isParent?) ? true : false
  end
  
  def colorArr()
   @x = 200
   @y = 200
   @curr_color = 0
   @side_length = 60
   @color_to_use = 7 # arr.size  - 1
   @arr = []
   @arr << '#111111'
   @arr << '#222222'
   @arr << '#333333'
   @arr << '#444444'
   @arr << '#555555'
   @arr << '#666666'
   @arr << '#777777'
   @arr << '#888888'
   @arr << '#999999'
   @arr << '#aaaaaa'
   @arr << '#bbbbbb'
   @arr << '#cccccc'
   @arr << '#dddddd'
   @arr << '#eeeeee'
   @arr << '#ffffff'
   return @arr
  end
  def show_box_forward()
    @x+=10
    
    style="width:10px; height:10px;background-color:"+@arr[@curr_color]+";position:absolute; left:"+@x.to_s+"px; top:"+@y.to_s+"px;"
    @curr_color+=1
    if @curr_color > @color_to_use
      @curr_color = 0
    end
    return style
  end
  
  def show_box_down()
    @y+=10
    style="width:10px; height:10px;background-color:"+@arr[@curr_color]+";position:absolute; left:"+@x.to_s+"px; top:"+@y.to_s+"px;"
    @curr_color+=1
    if @curr_color > @color_to_use
      @curr_color = 0
    end
    return style
  end
  def show_box_back()
    @x-=10
    style="width:10px; height:10px;background-color:"+@arr[@curr_color]+";position:absolute; left:"+@x.to_s+"px; top:"+@y.to_s+"px;"
    @curr_color+=1
    if @curr_color > @color_to_use
      @curr_color = 0
    end
    return style
  end
  def show_box_up()
    @y-=10
    style="width:10px; height:10px;background-color:"+@arr[@curr_color]+";position:absolute; left:"+@x.to_s+"px; top:"+@y.to_s+"px;"
    @curr_color+=1 
    if @curr_color > @color_to_use
      @curr_color = 0
    end
    return style
  end
  
 
end
