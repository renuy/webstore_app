class Member < ActiveRecord::Base
belongs_to :user
has_many :card
has_many :valid_card, :class_name=>"Card", :finder_sql =>
    'SELECT card.* ' +
    'FROM cards card ' +
    'WHERE card.member_id = #{id} AND card.card_id NOT IN (SELECT ch.card_id FROM card_histories ch WHERE ch.member_id= #{id})'
belongs_to :branch
has_many :read_shelf
has_many :read_next_shelf
has_many :lost_card, :class_name => "CardHistory"
has_many :overdue
attr_accessor :default
  
  
  def balanceDueAmount
    self.overdue.empty? ? 0 : self.overdue[0].amount
  end
  
  def payPerBook?
    self.valid_card[0].payPerBook?
  end
  
  def default
    self.valid_card[0].payPerBook? ? 'N' : 'D' 
  end
  
end
