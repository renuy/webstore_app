class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         #:recoverable, :rememberable, :trackable, 
         :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :username, :parent_id
  attr_accessor :ksu
  before_save :encrypt_password #should this be before create
  validate :kids_profile #should this be before create
  has_many :member, :conditions => ["status in (?)", [1,2]]
  has_many :kids, :foreign_key => "parent_id", :class_name => "User"
  has_many :book_lists
  def valid_password?(pass)
  
    pwd = Base64.encode64  Digest::SHA1.digest(pass)
    pwd.eql?(self.encrypted_password+"\n") #addition \n introduced in ror excryption. not there in legacy
    #logger.debug "Processing the request..."+pwd
  end
  def kids_profile
    if self.ksu.eql?('y') and (self.parent_id.nil? or self.parent_id.blank? or self.parent_id == 0)
      return false
    else
      return true
    end
  end
  def encrypt_password
    unless @password.blank?
      self.password_salt = ""
      pwd = Base64.encode64  Digest::SHA1.digest(@password)
      self.encrypted_password = pwd.strip 
    end
  end
  
  def isKid?
    self.parent_id.nil? ? false : true
  end
  
  def isParent?
    self.parent_id.nil? ? true : false
  end
end
