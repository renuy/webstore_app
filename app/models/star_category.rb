class StarCategory < ActiveRecord::Base
  belongs_to :title, :class_name => "Title" , :foreign_key => "title_id"
  
end
