class OrdersController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /orders
  # GET /orders.xml
  def index
    @orders = Order.find_by_user_id(current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @order = Order.new
    @order.order_for = params[:for]
    @order.channel = "Web"
    @order.user_id = current_user.id
    @order.member_id = params[:md]
    mem = Member.find(params[:md])
    @order.card_id = mem.valid_card[0].card_id
    @order.branch_id = 801 #remove hard coding
    @order.state = "PrePayment"
    @order.months = params[:m]
    @order.amount = mem.valid_card[0].renewAmount(params[:m].to_i)
    
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])

    
      if @order.save
        if @order.charge.eql?("YES")
           redirect_to(:controller=>"payments", :action=>"new", :order_id => @order.id )
        else
          redirect_to(@order, :notice => 'Order was successfully created.') 
        end
      else
        render :action => "new" 
      end
    
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Order.find(params[:id])
    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

end
