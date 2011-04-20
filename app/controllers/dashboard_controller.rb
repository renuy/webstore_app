class DashboardController < ApplicationController
  def index
    params = {:page=> 1, :per_page=>3 }
    @shelf0 = StarCategory.find_all_by_star_type('NA').paginate(:page=> params[:page], :per_page => params[:per_page])
    params = {:page=> 1, :per_page=>1 }
    @shelf1 = StarCategory.find_all_by_star_type('TT').paginate(:page=> params[:page], :per_page => params[:per_page])
    params = {:page=> 1, :per_page=>1}
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

end
