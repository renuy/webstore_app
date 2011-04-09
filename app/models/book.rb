class Book < ActiveRecord::Base
  belongs_to :title
  belongs_to :branch
  belongs_to :catalogued_branch, :class_name => 'Branch', :foreign_key => 'catalogued_branch_id'
  
end
