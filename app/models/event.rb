class Event < ActiveRecord::Base

  validates :email, :presence => true
  validates :guest_name, :presence => true
  validates :mphone, :presence => true

end
