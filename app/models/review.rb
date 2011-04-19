class Review < ActiveRecord::Base
  belongs_to :title
  belongs_to :user
  attr_accessor :d_user_id, :d_title_id
  before_validation( :set_title_and_user , :on => :create )
  validates :title_id, :presence => true, :uniqueness => {:scope => :user_id}
  validates :user_id, :presence => true
  validate :heading, :length => { :maximum => 250 }
  validate :description, :length => { :maximum => 1000 }
  
  
  before_save :validate_user
  before_destroy :validate_user
  
  def self.search(params)
    if params[:user_id].eql?("0") and params[:title_id].eql?("0")
      Review.all
    elsif params[:user_id].eql?("0")
      Review.find_all_by_title_id(params[:title_id].to_i)
    elsif params[:title_id].eql?("0")
      Review.find_all_by_user_id(params[:user_id].to_i)
    else
      Review.find_all_by_user_id_and_title_id(params[:user_id].to_i, params[:title_id].to_i)
    end
  end
  
  private
  def set_title_and_user
    self.title_id = d_title_id.to_i
    self.user_id = d_user_id.to_i
  end
  
  def validate_user
    if self.user_id != d_user_id.to_i
      errors.add(:user_id, ' not authorised to change')
      return false
    end
  end
end
