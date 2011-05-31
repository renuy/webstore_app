class QuizzesController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :destroy, :edit, :new, :update]
  before_filter :authenticate_strata_user!, :only => [:create, :destroy, :edit, :new, :update]

  # GET /quizzes
  # GET /quizzes.xml
  def index
    @shelf0 = Quiz.all(:order => "id desc").paginate(:page =>params[:page],:per_page=>params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quizzes }
    end
  end
  def search
    
    @shelf0 = Quiz.find_all_by_title_id(params[:title_id]).paginate(:page =>params[:page],:per_page=>params[:per_page])
    render 'index'
  end  
  # GET /quizzes/1
  # GET /quizzes/1.xml
  def show
    @quiz = Quiz.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quiz }
    end
  end

  # GET /quizzes/new
  # GET /quizzes/new.xml
  def new
    @quiz = Quiz.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quiz }
    end
  end

  # GET /quizzes/1/edit
  def edit
    @quiz = Quiz.find(params[:id])
  end

  # POST /quizzes
  # POST /quizzes.xml
  def create
    @quiz = Quiz.new(params[:quiz])

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to(@quiz, :notice => 'Quiz was successfully created.') }
        format.xml  { render :xml => @quiz, :status => :created, :location => @quiz }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quiz.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quizzes/1
  # PUT /quizzes/1.xml
  def update
    @quiz = Quiz.find(params[:id])

    respond_to do |format|
      if @quiz.update_attributes(params[:quiz])
        format.html { redirect_to(@quiz, :notice => 'Quiz was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quiz.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.xml
  def destroy
    @quiz = Quiz.find(params[:id])
    @quiz.destroy

    respond_to do |format|
      format.html { redirect_to(quizzes_url) }
      format.xml  { head :ok }
    end
  end
  
  def authenticate_strata_user!
    if  !current_user.strata_employee? 
      flash[:error] = "Not authorized to update"
      respond_to do |format|
        format.html {redirect_to quizzes_path}# new.html.erb
        format.xml  
        
      end
    end
  end
end
