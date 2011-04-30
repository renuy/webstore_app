class Favourite < ActiveRecord::Base

  belongs_to :user
  
  belongs_to :category, :class_name=>"Category", :foreign_key => :item_id
  #belongs_to :author, foreign_key => :item_id, :condition => ["favourite = ?",'AUTHOR']
  #belongs_to :title, foreign_key => :item_id, :condition => ["favourite = ?",'TITLE']
end
