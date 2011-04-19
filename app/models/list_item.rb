class ListItem < ActiveRecord::Base
  belongs_to :book_list
  belongs_to :title
  belongs_to :read_next_shelf ,:foreign_key => :shelf_id
  belongs_to :read_shelf ,:foreign_key => :shelf_id
  attr_accessor :d_category, :d_user_id
  validates :title_id, :presence => true
  before_save :set_book_list
  
  
  def set_book_list
    book_list = 0
    case 
      when self.d_category.eql?("rs")
        category = 'Read'
      when self.d_category.eql?("rns")
        category = 'Bookmarked'
      when self.d_category.eql?("rnsd")
        category = 'Reading'
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
  
  def self.upsert(title_id, user_id, category)
    lists = ListItem.find_all_by_title_id_and_book_list_id(title_id, BookList.find_all_by_user_id(user_id).collect{|x| x.id})
    list_item = lists.empty? ? ListItem.new : lists[0]
    list_item.title_id = title_id
    list_item.d_category = category
    list_item.d_user_id = user_id
    list_item.save
    list_item
  end
  
  
end
