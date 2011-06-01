class BookListsController < ApplicationController
  before_filter :authenticate_user!
  # GET /book_lists
  # GET /book_lists.xml
  def index
    
    @shelves = BookList.find_all_by_user_id(current_user.id)
    if(@shelves.size > 0)
      @shelf0 = ListItem.find_all_by_book_list_id(@shelves[0].id).paginate(:page=>1, :per_page => 3)
    else
      @shelf0 = []
    end
    if(@shelves.size > 1)
      @shelf1 = ListItem.find_all_by_book_list_id(@shelves[1].id).paginate(:page=>1, :per_page => 2)
    else
      @shelf1 = []
    end
    
    if(@shelves.size > 2)      
      @shelf2 = ListItem.find_all_by_book_list_id(@shelves[2].id).paginate(:page=>1, :per_page => 2)
    else
      @shelf2 = []
    end
    if(@shelves.size > 3)
      @shelf3 = ListItem.find_all_by_book_list_id(@shelves[3].id).paginate(:page=>1, :per_page => 2)
    else
      @shelf3 = []
    end
    if(@shelves.size > 4)
      @shelf4 = ListItem.find_all_by_book_list_id(@shelves[4].id).paginate(:page=>1, :per_page => 2)
    else
      @shelf4 = []
    end
    if(@shelves.size > 5)
      @shelf5 = ListItem.find_all_by_book_list_id(@shelves[5].id).paginate(:page=>1, :per_page => 2)
    else
      @shelf5 = []
    end
    if(@shelves.size > 6)
      @shelf6 = ListItem.find_all_by_book_list_id(@shelves[6].id).paginate(:page=>1, :per_page => 3)
    else
      @shelf6 = []
    end
    if(@shelves.size > 7)
      @shelf7 = ListItem.find_all_by_book_list_id(@shelves[7].id).paginate(:page=>1, :per_page => 2)
    else
      @shelf7 = []
    end
    if(@shelves.size > 8)
      @shelf8 = ListItem.find_all_by_book_list_id(@shelves[8].id).paginate(:page=>1, :per_page => 2)
    else
      @shelf8 = []
    end
  end

  def index_k
    
    @shelves =[]
    @shelf0 = []
    @shelf1 = []
    @shelf2 = []
    @shelf3 = []
    @shelf4 = []
    @shelf5 = []
    @shelf6 = []
    @shelf7 = []
    @shelf8 = []
    @kids = User.find_all_by_parent_id(current_user.id)
    @kids.each do |kid|
      shelves = BookList.find_all_by_user_id(kid.id)
      @shelves << shelves
      
      shelf0 = []
      if(shelves.size > 0)
        shelf0 = ListItem.find_all_by_book_list_id(shelves[0].id).paginate(:page=>1, :per_page => 3)
      end
      @shelf0 << shelf0
       
      shelf1 = []
      if(shelves.size > 1)
        shelf1 = ListItem.find_all_by_book_list_id(shelves[1].id).paginate(:page=>1, :per_page => 2)
      end
      @shelf1 << shelf1
      
      shelf2 = []
      if(shelves.size > 2)      
        shelf2 = ListItem.find_all_by_book_list_id(shelves[2].id).paginate(:page=>1, :per_page => 2)
      end
      @shelf2 << shelf2
      
      shelf3 = []
      if(shelves.size > 3)
        shelf3 = ListItem.find_all_by_book_list_id(shelves[3].id).paginate(:page=>1, :per_page => 2)
      end
      @shelf3 << shelf3
      
      shelf4 = []
      if(shelves.size > 4)
        shelf4 = ListItem.find_all_by_book_list_id(shelves[4].id).paginate(:page=>1, :per_page => 2)
      end
      @shelf4 << shelf4
      
      shelf5 = []
      if(shelves.size > 5)
        shelf5 = ListItem.find_all_by_book_list_id(shelves[5].id).paginate(:page=>1, :per_page => 2)
      end
      @shelf5 << shelf5
      
      shelf6 = []
      if(shelves.size > 6)
        shelf6 = ListItem.find_all_by_book_list_id(shelves[6].id).paginate(:page=>1, :per_page => 3)
      end
      @shelf6 << shelf6
      
      shelf7 = []
      if(shelves.size > 7)
        shelf7 = ListItem.find_all_by_book_list_id(shelves[7].id).paginate(:page=>1, :per_page => 2)
      end
      @shelf7 << shelf7
      
      shelf8 = []
      if(@shelves.size > 8)
        shelf8 = ListItem.find_all_by_book_list_id(shelves[8].id).paginate(:page=>1, :per_page => 2)
      end
      @shelf8 << shelf8
      
    end
  end
  # GET /book_lists/1
  # GET /book_lists/1.xml
  def show
    @collection_name = BookList.find(params[:id])
    
    @shelf0 = ListItem.find_all_by_book_list_id(@collection_name.id).paginate(:page=>params[:page], :per_page => params[:per_page])
    #unless params[:notice].blank? 
    #  flash[:notice] = params[:notice]  
    #end
  end

  # GET /book_lists/new
  # GET /book_lists/new.xml
  def new
    @book_list = BookList.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book_list }
    end
  end

  # GET /book_lists/1/edit
  def edit
    @book_list = BookList.find(params[:id])
  end

  # POST /book_lists
  # POST /book_lists.xml
  def create
    @book_list = BookList.new(params[:book_list])

    respond_to do |format|
      if @book_list.save
        format.html { redirect_to(@book_list, :notice => 'Book list was successfully created.') }
        format.xml  { render :xml => @book_list, :status => :created, :location => @book_list }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @book_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /book_lists/1
  # PUT /book_lists/1.xml
  def update
    @book_list = BookList.find(params[:id])

    respond_to do |format|
      if @book_list.update_attributes(params[:book_list])
        format.html { redirect_to(@book_list, :notice => 'Book list was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /book_lists/1
  # DELETE /book_lists/1.xml
  def destroy
    @book_list = BookList.find(params[:id])
    @book_list.destroy

    respond_to do |format|
      format.html { redirect_to(book_lists_url) }
      format.xml  { head :ok }
    end
  end
end
