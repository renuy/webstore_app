class Category < ActiveRecord::Base
  has_many :titles
  attr_accessible :name, :division
end
