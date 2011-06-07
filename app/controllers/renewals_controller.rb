class RenewalsController < ApplicationController
  
  before_filter :authenticate_user!

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
    @renewal.pay_mode = Signup::PAYMENT_MODES[:card]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @renewal }
    end
  end

  #def show
  #  @renewal = Renewal.find(params[:id])
  #end
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
end
