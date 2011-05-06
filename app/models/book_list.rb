class BookList < ActiveRecord::Base
  belongs_to :users
  has_many :list_items
  
  CATEGORY = {
    :READ   => 'READ',
    :BOOKMARK  => 'BOOKMARK', 
    :ORDER   => 'ORDER',
    :READING => 'READING',
    :RECOMMEND => 'RECOMMEND'
    
  }  

end
