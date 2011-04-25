class RenewalsController < ApplicationController
  # GET /renewals
  # GET /renewals.xml
  def index
    @renewals = Renewal.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @renewals }
    end
  end

  # GET /renewals/1
  # GET /renewals/1.xml
  def show
    @renewal = Renewal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @renewal }
    end
  end

  # GET /renewals/new
  # GET /renewals/new.xml
  def new
    @renewal = Renewal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @renewal }
    end
  end

  # GET /renewals/1/edit
  def edit
    @renewal = Renewal.find(params[:id])
  end

  # POST /renewals
  # POST /renewals.xml
  def create
    @renewal = Renewal.new(params[:renewal])

    respond_to do |format|
      if @renewal.save
        format.html { redirect_to(@renewal, :notice => 'Renewal was successfully created.') }
        format.xml  { render :xml => @renewal, :status => :created, :location => @renewal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @renewal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /renewals/1
  # PUT /renewals/1.xml
  def update
    @renewal = Renewal.find(params[:id])

    respond_to do |format|
      if @renewal.update_attributes(params[:renewal])
        format.html { redirect_to(@renewal, :notice => 'Renewal was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @renewal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /renewals/1
  # DELETE /renewals/1.xml
  def destroy
    @renewal = Renewal.find(params[:id])
    @renewal.destroy

    respond_to do |format|
      format.html { redirect_to(renewals_url) }
      format.xml  { head :ok }
    end
  end
end
