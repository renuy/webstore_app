class ReviewsController < ApplicationController
before_filter :authenticate_user!, :only => [:create, :update, :destroy, :new, :edit]
  
  def upsert
    title_id = params[:title_id]
    user_id = current_user.id
    @review = Review.find_by_user_id_and_title_id(user_id, title_id)
    if @review.nil?
      redirect_to new_review_path  :title_id =>  title_id
    else
      redirect_to edit_review_path(@review.id, :title_id=>title_id)
    end
  end
  
  def search
    
    @shelf0 = Review.search(params).paginate(:page =>params[:page],:per_page=>params[:per_page])
    render 'index'
  end  
  
  # GET /reviews
  # GET /reviews.xml
  def index
    @shelf0 = Review.all(:order => "id desc").paginate(:page =>params[:page],:per_page=>params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.xml
  def show
    @review = Review.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.xml
  def new
    @review = Review.new
    @title = Title.find(params[:title_id])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
    @title = Title.find(params[:title_id])
  end

  # POST /reviews
  # POST /reviews.xml
  def create
    @review = Review.new(params[:review])

    respond_to do |format|
      if @review.save
        format.html { redirect_to(@review, :notice => 'Review was successfully created.') }
        format.xml  { render :xml => @review, :status => :created, :location => @review }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.xml
  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to(@review, :notice => 'Review was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.xml
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to(reviews_url) }
      format.xml  { head :ok }
    end
  end
end
