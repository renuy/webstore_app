class ListItem < ActiveRecord::Base
  belongs_to :book_list
  belongs_to :title
  belongs_to :member
  belongs_to :read_next_shelf ,:foreign_key => :shelf_id
  belongs_to :read_shelf ,:foreign_key => :shelf_id
  attr_accessor :d_category, :d_user_id
  validates :title_id, :presence => true
  before_save :set_book_list
  #before_save :valid_category_and_user?
  validate :verify_card
  validate :valid_category_and_user?
  before_destroy :valid_category_and_user?
  def verify_card
    if [BookList::CATEGORY[:BOOKMARK],BookList::CATEGORY[:ORDER], BookList::CATEGORY[:TRANSFER]].include?(self.d_category) and self.member_id.nil?
      errors.add(:member_id, "Please select membership")
      return false
    end
    
    if self.d_category.eql?(BookList::CATEGORY[:ORDER]) and !self.member.valid_card[0].plan.deliver.upcase.eql?('YES')
      errors.add(:member_id, "Sorry, the plan subscribed by you does not have door deliver. Please visit your branch to get the book issued on this card")
      return false
    end
  end
  
  def set_book_list
    book_list = 0
    case 
      when self.d_category.eql?(BookList::CATEGORY[:READ])
        category = BookList::CATEGORY[:READ]
      when self.d_category.eql?(BookList::CATEGORY[:BOOKMARK])
        category = BookList::CATEGORY[:BOOKMARK]
      when self.d_category.eql?(BookList::CATEGORY[:READING])
        category = BookList::CATEGORY[:READING]
      when self.d_category.eql?(BookList::CATEGORY[:ORDER])
        category = BookList::CATEGORY[:ORDER]
      else
        category = self.d_category
    end
    book_list = BookList.find_by_user_id_and_category(self.d_user_id, category)
    if book_list.nil?
      book_list = BookList.new
      book_list.user_id = self.d_user_id
      book_list.category = category
      book_list.save
      book_list = BookList.find_by_user_id_and_category(self.d_user_id, category)
    end
    self.book_list_id = book_list.id
  end
  
  def self.search(title_id, user_id)
    lists = ListItem.find_all_by_title_id_and_book_list_id(title_id, BookList.find_all_by_user_id(user_id).collect{|x| x.id})
    list_item = lists.empty? ? nil : lists[0]
    return list_item
  end
  
  def self.upsert(title_id, user_id, category)
    lists = ListItem.find_all_by_title_id_and_book_list_id(title_id, BookList.find_all_by_user_id(user_id).collect{|x| x.id})
    list_item = lists.empty? ? ListItem.new : lists[0]
    list_item.title_id = title_id
    list_item.d_category = category
    list_item.d_user_id = user_id
    list_item.save
    list_item
  end
  def valid_category_and_user?
    if !self.book_list_id.nil? and (self.d_user_id.to_i != self.book_list.user_id )
      errors.add(:title_id, "this list item does not belong to you")
      return false
    end
    #logger.debug(self.book_list.category)
    if !self.book_list_id.nil?  and [BookList::CATEGORY[:ORDER],BookList::CATEGORY[:READ], BookList::CATEGORY[:READING]].include?( self.book_list.category) and !self.shelf_id.nil?
      errors.add(:title_id, "This is system generated, cannot be removed")
      return false
    end
    return true
  end
end
