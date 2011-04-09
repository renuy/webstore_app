class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         #:recoverable, :rememberable, :trackable, 
         :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
  before_save :encrypt_password #should this be before create
  has_many :member
  def valid_password?(pass)
  
    pwd = Base64.encode64  Digest::SHA1.digest(pass)
    pwd.eql?(self.encrypted_password+"\n") #addition \n introduced in ror excryption. not there in legacy
    #logger.debug "Processing the request..."+pwd
  end
  def encrypt_password
    unless @password.blank?
      self.password_salt = ""
      pwd = Base64.encode64  Digest::SHA1.digest(@password)
      self.encrypted_password = pwd.strip 
    end
end
end
