class Title < ActiveRecord::Base  
  belongs_to :publisher
  belongs_to :author
  belongs_to :category
  has_many   :stock, :class_name =>"Stock"
  has_many   :reviews, :class_name => "Reviews" , :order =>"review_type"
  has_many   :quiz, :class_name => "Quiz"
  attr_accessible :title, :yearofpublication, :edition, :isbn10, :isbn13, :noofpages, :language ,:no_of_rented, :title_type
  
  BRANCH = ['1','1','3']
  #has_many :branch, :through => :stock
  
  validates :title, :presence => true
  
  searchable do
    text :title, :stored => true, :more_like_this => true, :boost => 5
    text :author, :stored => true, :more_like_this => true , :boost => 2 do
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
    integer :no_of_rented, :stored => true
    string :title_type, :stored => true
    #integer :stock, :references => Stock, :multiple => true
    #integer :branch, :references => Stock, :multiple => true
    integer :branch, :multiple => true do
      stock.collect{|x| x.branch_id}
    end
  end   
  
  
  def self.most_read(query, page, per_page)
    search = Sunspot.new_search(Title) do
      paginate(:page =>  page, :per_page =>  per_page)
    end
    search.build do
      keywords( query  )
    end
    
    search.build do
      order_by(:no_of_rented, :desc)
    end
    search.build do 
      with(:branch).any_of Title::BRANCH
    end
    shelfMR = search.execute
    
    return shelfMR.results
    
  end
  
  def self.new_arrivals(query, page, per_page)
    search = Sunspot.new_search(Title) do
      paginate(:page =>  page, :per_page =>  per_page)
      without(:title_type).equal_to('M')
    end
    search.build do
      keywords( query  )
    end
    search.build do
      without(:title_type).equal_to('M')
    end
    search.build do
      order_by(:id, :desc)
    end
    search.build do 
      with(:branch).any_of Title::BRANCH
    end
    shelfNR = search.execute
    
    return shelfNR.results
    
  end
  
  def self.kids(query, page, per_page)
    #Title.find_all_by_category(['34','35','36','37','38','39'])
    
    newSearch = Sunspot.new_search(Title) do
      paginate(:page => page, :per_page => per_page)
      facet(:category_id)
    end
    newSearch.build do
      keywords query do
        highlight :title, :author
      end
    end
    
    newSearch.build do
      order_by(:no_of_rented, :desc)
    end
    
    newSearch.build do 
      with(:category_id).any_of ['34','35','36','37','38','39']
    end
    
    newSearch.build do 
      with(:branch).any_of Title::BRANCH
    end
    shelfNR = newSearch.execute
    
    return shelfNR.results

  end
end
