class PendingTitlesForCollectionsController < ApplicationController
  # GET /pending_titles_for_collections
  # GET /pending_titles_for_collections.xml
  def index
    @pending_titles_for_collections = PendingTitlesForCollection.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pending_titles_for_collections }
    end
  end

  # GET /pending_titles_for_collections/1
  # GET /pending_titles_for_collections/1.xml
  def show
    @pending_titles_for_collection = PendingTitlesForCollection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pending_titles_for_collection }
    end
  end

  # GET /pending_titles_for_collections/new
  # GET /pending_titles_for_collections/new.xml
  def new
    @pending_titles_for_collection = PendingTitlesForCollection.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pending_titles_for_collection }
    end
  end

  # GET /pending_titles_for_collections/1/edit
  def edit
    @pending_titles_for_collection = PendingTitlesForCollection.find(params[:id])
  end

  # POST /pending_titles_for_collections
  # POST /pending_titles_for_collections.xml
  def create
    @pending_titles_for_collection = PendingTitlesForCollection.new(params[:pending_titles_for_collection])

    respond_to do |format|
      if @pending_titles_for_collection.save
        format.html { redirect_to(@pending_titles_for_collection, :notice => 'Pending titles for collection was successfully created.') }
        format.xml  { render :xml => @pending_titles_for_collection, :status => :created, :location => @pending_titles_for_collection }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pending_titles_for_collection.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pending_titles_for_collections/1
  # PUT /pending_titles_for_collections/1.xml
  def update
    @pending_titles_for_collection = PendingTitlesForCollection.find(params[:id])

    respond_to do |format|
      if @pending_titles_for_collection.update_attributes(params[:pending_titles_for_collection])
        format.html { redirect_to(@pending_titles_for_collection, :notice => 'Pending titles for collection was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pending_titles_for_collection.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pending_titles_for_collections/1
  # DELETE /pending_titles_for_collections/1.xml
  def destroy
    @pending_titles_for_collection = PendingTitlesForCollection.find(params[:id])
    @pending_titles_for_collection.destroy

    respond_to do |format|
      format.html { redirect_to(pending_titles_for_collections_url) }
      format.xml  { head :ok }
    end
  end
end
