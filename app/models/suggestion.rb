class Suggestion < ActiveRecord::Base
  belongs_to :title
  belongs_to :by, :class_name => 'User', :foreign_key => :by_id
  belongs_to :to, :class_name => 'User', :foreign_key => :to_id
  validates :title_id, :presence => true, :uniqueness => {:scope => :to_id}
  validates :by_id, :presence => true
  validates :to_id, :presence => true

end
