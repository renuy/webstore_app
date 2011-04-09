class CollectionNamesController < ApplicationController
  # GET /collection_names
  # GET /collection_names.xml
  def index
    @collection_names = CollectionName.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @collection_names }
    end
  end

  # GET /collection_names/1
  # GET /collection_names/1.xml
  def show
  
    @collection_name = CollectionName.find(params[:id])
    params1 = {:page=> params[:page], :per_page=>params[:per_page], :cnameid => @collection_name.id}
    @shelf0 = Collection.for_home_page(params1)

  end

  # GET /collection_names/new
  # GET /collection_names/new.xml
  def new
    @collection_name = CollectionName.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @collection_name }
    end
  end

  # GET /collection_names/1/edit
  def edit
    @collection_name = CollectionName.find(params[:id])
  end

  # POST /collection_names
  # POST /collection_names.xml
  def create
    @collection_name = CollectionName.new(params[:collection_name])

    respond_to do |format|
      if @collection_name.save
        format.html { redirect_to(@collection_name, :notice => 'Collection name was successfully created.') }
        format.xml  { render :xml => @collection_name, :status => :created, :location => @collection_name }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @collection_name.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /collection_names/1
  # PUT /collection_names/1.xml
  def update
    @collection_name = CollectionName.find(params[:id])

    respond_to do |format|
      if @collection_name.update_attributes(params[:collection_name])
        format.html { redirect_to(@collection_name, :notice => 'Collection name was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @collection_name.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /collection_names/1
  # DELETE /collection_names/1.xml
  def destroy
    @collection_name = CollectionName.find(params[:id])
    @collection_name.destroy

    respond_to do |format|
      format.html { redirect_to(collection_names_url) }
      format.xml  { head :ok }
    end
  end
end
