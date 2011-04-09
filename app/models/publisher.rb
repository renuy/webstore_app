class Publisher < ActiveRecord::Base
  has_many :titles
  
  attr_accessible :name, :country
  
  validates :name, :presence => true
end
