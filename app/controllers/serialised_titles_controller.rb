class SerialisedTitlesController < ApplicationController
  # GET /serialised_titles
  # GET /serialised_titles.xml
  def index
    @serialised_titles = SerialisedTitle.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @serialised_titles }
    end
  end

  # GET /serialised_titles/1
  # GET /serialised_titles/1.xml
  def show
    @serialised_title = SerialisedTitle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @serialised_title }
    end
  end

  # GET /serialised_titles/new
  # GET /serialised_titles/new.xml
  def new
    @serialised_title = SerialisedTitle.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @serialised_title }
    end
  end

  # GET /serialised_titles/1/edit
  def edit
    @serialised_title = SerialisedTitle.find(params[:id])
  end

  # POST /serialised_titles
  # POST /serialised_titles.xml
  def create
    @serialised_title = SerialisedTitle.new(params[:serialised_title])

    respond_to do |format|
      if @serialised_title.save
        format.html { redirect_to(@serialised_title, :notice => 'Serialised title was successfully created.') }
        format.xml  { render :xml => @serialised_title, :status => :created, :location => @serialised_title }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @serialised_title.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /serialised_titles/1
  # PUT /serialised_titles/1.xml
  def update
    @serialised_title = SerialisedTitle.find(params[:id])

    respond_to do |format|
      if @serialised_title.update_attributes(params[:serialised_title])
        format.html { redirect_to(@serialised_title, :notice => 'Serialised title was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @serialised_title.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /serialised_titles/1
  # DELETE /serialised_titles/1.xml
  def destroy
    @serialised_title = SerialisedTitle.find(params[:id])
    @serialised_title.destroy

    respond_to do |format|
      format.html { redirect_to(serialised_titles_url) }
      format.xml  { head :ok }
    end
  end
end
