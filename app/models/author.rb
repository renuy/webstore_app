class Author < ActiveRecord::Base
  has_many :titles
  attr_accessible :name, :firstname, :middlename, :lastname
  validates :firstname, :presence => true
  
  before_save :fullName
  
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      where('trim(name) is not null')
    end
  end
  
  def fullName
    self.name = firstname << ' ' << middlename << ' ' << lastname
  end
end
