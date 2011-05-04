class ListItemsController < ApplicationController
  before_filter :authenticate_user!
  
  def upsert
    title_id = params[:title_id]
    user_id = current_user.id
    category = params[:list]
    @list_item = ListItem.upsert(title_id, user_id, category) 
    redirect_to :action=>"show", :controller=>"book_lists", :id => @list_item.book_list_id, :per_page => 9, :page=> 1
  end

  # GET /list_items
  # GET /list_items.xml
  def index
    #@list_items = ListItem.all

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @list_items }
    #end
    redirect_to book_lists_path
  end

  # GET /list_items/1
  # GET /list_items/1.xml
  def show
    @list_item = ListItem.find(params[:id])
    redirect_to book_list_path(@list_item.book_list)
    
  end

  # GET /list_items/new
  # GET /list_items/new.xml
  def new
  
    @list_item = ListItem.find_by_title_id_and_book_list_id(params[:title_id], BookList.find_all_by_user_id(current_user.id).collect{|x| x.id})
    
    if !@list_item.nil? 
      redirect_to :action=>"edit", :controller=>"list_items", :id => @list_item.id, :cat => params[:cat]
    else
      @list_item = ListItem.new
      @list_item.title_id = params[:title_id]
      @list_item.d_category = params[:cat]
      @list_item.d_user_id = current_user.id
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @list_item }
      end
    end
  end

  # GET /list_items/1/edit
  def edit
    
    @list_item = ListItem.find(params[:id])
    @list_item.d_user_id = current_user.id
    if !params[:cat].nil?
      @list_item.d_category = params[:cat]
    else
      @list_item.d_category = @list_item.book_list.category
    end
  end

  # POST /list_items
  # POST /list_items.xml
  def create
    @list_item = ListItem.new(params[:list_item])

    respond_to do |format|
      if @list_item.save
        format.html { redirect_to(@list_item, :notice => 'List item was successfully created.') }
        format.xml  { render :xml => @list_item, :status => :created, :location => @list_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @list_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /list_items/1
  # PUT /list_items/1.xml
  def update
    @list_item = ListItem.find(params[:id])

    respond_to do |format|
      if @list_item.update_attributes(params[:list_item])
        format.html { redirect_to(@list_item, :notice => 'List item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @list_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /list_items/1
  # DELETE /list_items/1.xml
  def destroy
    @list_item = ListItem.find(params[:id])
    @list_item.d_user_id = current_user.id
    respond_to do |format|
      if @list_item.destroy
        format.html { redirect_to(list_items_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @list_item.errors, :status => :unprocessable_entity }
      end
    end  
  end
end
