class Item < ActiveRecord::Base
  belongs_to :order
  has_one :title
end
