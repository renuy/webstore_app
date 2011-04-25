class DashboardController < ApplicationController
  def index
    params = {:page=> 1, :per_page=>3 }
    @shelf0 = StarCategory.find_all_by_star_type('NR').paginate(:page=> params[:page], :per_page => params[:per_page])
    params = {:page=> 1, :per_page=>1 }
    @shelf1 = Title.most_read("", params[:page], params[:per_page])
    params = {:page=> 1, :per_page=>1}
    
    @shelf2 = [] 
    @shelf2 = Review.all(:order => "id   desc").paginate(:page=> 1, :per_page => 2)
    @kidshelf =[]
    @myshelf = []
    @mysugges = []
    myshelf = []
    kidshelf = []
    mysuggess=[]
    if user_signed_in?
      user = current_user
      user.book_lists.each do |book_list|
        book_list.list_items.each do |rs|
          myshelf << rs
        end
      end
      @myshelf = myshelf.paginate(:page => 1, :per_page => 1)
      
      user.kids.each do |kid|
        kid.book_lists.each do |book_list|
          book_list.list_items.each do |rs|
            kidshelf << rs
          end
        end
      end
      @kidshelf = kidshelf.paginate(:page => 1, :per_page => 1)
      
      mysugges = Suggestion.find_all_by_by_id(user.id)
      @mysugges = mysugges.paginate(:page => 1, :per_page => 3)
    end
  end
  
  def show
    shelf = params[:shelf]
    @shelf0 = []
    @shelf_name =""
    case 
      when shelf.eql?("MR")
        @shelf0 = Title.most_read("", params[:page], params[:per_page])
        @shelf_name="MOST READ"
      when  shelf.eql?("NR")
        @shelf0 = Title.new_arrivals("", params[:page], params[:per_page])
        @shelf_name="NEW BOOKS"
    end
    render 'titles/show'        
    
  end
end
