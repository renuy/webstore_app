class DashboardController < ApplicationController
  def index
    params = {:page=> 1, :per_page=>3 }
    @shelf0 = StarCategory.find_all_by_star_type('NR').paginate(:page=> params[:page], :per_page => params[:per_page])
    params = {:page=> 1, :per_page=>2 }
    @shelf1 = Title.most_read("", params[:page], params[:per_page])
    params = {:page=> 1, :per_page=>1}
    @quizzes = Quiz.find(:all).paginate(:page=>1,:per_page=>3)  
    @shelf2 = [] 
    @shelf2 = Review.all(:order => "id   desc").paginate(:page=> 1, :per_page => 2)

    @kidshelf =[]
    @myshelf = []
    @mysugges = []
    myshelf = []
    kidshelf = []
    mysuggess=[]
    if user_signed_in?
      #@shelf2 = Review.find_all_by_user_id(current_user.id, :order => "id   desc").paginate(:page=> 1, :per_page => 2)
      user = current_user
      
      myshelf = ListItem.find_all_by_book_list_id(user.book_lists.collect{|x| x.id}, :limit => 1)
      @myshelf = myshelf.paginate(:page => 1, :per_page => 1)
      
      #user.kids.each do |kid|
      #  rs = ListItem.find_by_book_list_id(kid.book_lists.collect{|x| x.id})
      #  kidshelf << rs unless rs.nil?
      #end
      #@kidshelf = kidshelf.paginate(:page => 1, :per_page => 1)
      @kidshelf = Title.kids("", 1, 1) #honeywell changes
      #mysugges = Suggestion.find_all_by_by_id(user.id, :limit => 1)
      #@mysugges = mysugges.paginate(:page => 1, :per_page => 3)
      @mysugges = StarCategory.find_all_by_star_type('CR').paginate(:page=> 1, :per_page => 3)
    else
      @myshelf = CurrentRead.all(:order => "cnt desc").paginate(:page => 1, :per_page => 1)
      @mysugges = StarCategory.find_all_by_star_type('CR').paginate(:page=> 1, :per_page => 3)
      @shelf3 = CurrentRead.all(:order => "cnt").paginate(:page => 1, :per_page => 2)
      @kidshelf = Title.kids("", 1, 1)
    end
  end
  
  def show
    shelf = params[:shelf]
    @shelf0 = []
    @shelf_name =""
    render_file = "show" 
    case 
      when shelf.eql?("MR")
        @shelf0 = Title.most_read("", params[:page], params[:per_page])
        @shelf_name="MOST READ"
        render_file = 'titles/show'
      when  shelf.eql?("NR")
        @shelf0 = Title.new_arrivals("", params[:page], params[:per_page])
        @shelf_name="NEW BOOKS"
        render_file = 'titles/show'
      when  shelf.eql?("CR")
        @shelf0 = StarCategory.find_all_by_star_type('CR').paginate(:page => params[:page], :per_page=>params[:per_page])
        @shelf_name="RECOMMENDED"
        render_file = 'show'
      when  shelf.eql?("CRR")
        @shelf0 = CurrentRead.all(:order => "cnt desc").paginate(:page => params[:page],  :per_page => params[:per_page])
        @shelf_name="CURRENT READS"
        render_file = 'show'
      when shelf.eql?("K")
        @shelf0 = Title.kids("",  params[:page],  params[:per_page])
        @shelf_name="KIDS SHELF"
        render_file = 'titles/show'
      when  shelf.eql?("LR")
        @shelf0 = CurrentRead.all(:order => "cnt").paginate(:page => params[:page],  :per_page => params[:per_page])
        @shelf_name="UNCHARTED"
        render_file = 'show'
    end
    render render_file       
    
  end
end
