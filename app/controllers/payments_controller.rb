class PaymentsController < ApplicationController
  
  # GET /payments
  # GET /payments.xml
  #def index
  #  @payments = Payment.all

  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.xml  { render :xml => @payments }
  #  end
  #end

  # GET /payments/1
  # GET /payments/1.xml
  #def show
  #  @payment = Payment.find(params[:id])

  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.xml  { render :xml => @payment }
  #  end
  #end

  # GET /payments/new
  # GET /payments/new.xml
  def new
    @payment = Payment.new
    case params[:for]
      when 'ren'
        @payment.payment_for = 'Renewal'
        renewal = Renewal.find(params[:id])
        @payment.txn_amount = renewal.amount 
        @payment.member_id = renewal.member_id
    end
    @payment.channel = "Web"
    @payment.user_id = current_user.id
    @payment.order_id =  params[:id]
    @payment.branch_id = 801 #remove hard coding
    @payment.state = "PrePayment"
    @payment.mode = 'Credit Card'
    @payment.fee = 15 #convinience fee
    @payment.amount = @payment.txn_amount + @payment.fee
    
    
    
  end

  # GET /payments/1/edit
  #def edit
  #  @payment = Payment.find(params[:id])
  #end

  # POST /payments
  # POST /payments.xml
  def create
    @payment = Payment.new(params[:payment])
    if @payment.save
      @payment.sent!
      render 'gateway'
    else
      render :action => "new"
    end
    
  end

  # PUT /payments/1
  # PUT /payments/1.xml
  #def update
  #  @payment = Payment.find(params[:id])

  #  respond_to do |format|
  #    if @payment.update_attributes(params[:payment])
  #      format.html { redirect_to(@payment, :notice => 'Payment was successfully updated.') }
  #      format.xml  { head :ok }
  #    else
  #      format.html { render :action => "edit" }
  #      format.xml  { render :xml => @payment.errors, :status => :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /payments/1
  # DELETE /payments/1.xml
  #def destroy
  #  @payment = Payment.find(params[:id])
  #  @payment.destroy

  #  respond_to do |format|
  #    format.html { redirect_to(payments_url) }
  #    format.xml  { head :ok }
  #  end
  #end
  
  def gatewayentry 
    order_Id = params[:Order_Id]
    merchant_Id = params[:Merchant_Id]
    redirect_Url = params[:redirect_Url]
    checksum = params[:Checksum]
    amount = params[:Amount]
    authDesc = params[:AuthDesc]
    payment = Payment.find(order_Id)
    
    case authDesc
      when "Y"
        payment.state = "SUCCESS"
        payment.details = "Thank you. Your credit card has been charged, your order will be executed shortly."
      when "B"
        payment.state = "UNKNOWN"
        payment.details = "Thank you. We will keep you posted regarding the status of your order through e-mail"
      when "N"
        payment.state = "FAILED"
        payment.details = "Your transaction has been declined by the merchant. Please verify your details and retry."
    end
    payment.save
    flash[:notice] = payment.details
    redirect_to current_user_path
  end
end
