class Title < ActiveRecord::Base  
  belongs_to :publisher
  belongs_to :author
  belongs_to :category
  has_many   :stock, :class_name =>"Stock"
  has_many   :reviews, :class_name => "Reviews" , :order =>"review_type"
  attr_accessible :title, :yearofpublication, :edition, :isbn10, :isbn13, :noofpages, :language 
  
  validates :title, :presence => true
  
  searchable do
    text :title, :stored => true, :more_like_this => true
    text :author, :stored => true, :more_like_this => true do
      unless author.nil? 
        author.name
      else
        ''
      end
    end
    text :category, :stored => true, :more_like_this => true do
      unless category.nil? 
        category.name
      else
        ''
      end
    end
    text :publisher, :stored => true, :more_like_this => true do
      unless publisher.nil? 
        publisher.name
      else
        ''
      end
    end
    integer :id, :stored => true
    integer :category_id, :references => Category, :stored => true
    integer :publisher_id, :references => Publisher, :stored => true
    integer :author_id, :references => Author, :stored => true
  end   
end
