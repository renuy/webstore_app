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
    @renewal.member_id = params[:md]
    mem = Member.find(params[:md])
    months = params[:m]
    @renewal.card_id = mem.valid_card[0].card_id
    @renewal.months = months
    @renewal.amount = mem.valid_card[0].renewAmount(months.to_i)
    @renewal.state = 'New'
    @renewal.from_date = mem.valid_card[0].expiry_date
    @renewal.to_date = mem.valid_card[0].newExpiry(months.to_i)
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

    if @renewal.save
      redirect_to :action=>"new", :controller=>"payments", :id => @renewal.id,:for=>'ren'
    else
      render :action => "new"
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
