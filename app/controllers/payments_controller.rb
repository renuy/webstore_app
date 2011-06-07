class PaymentsController < ApplicationController
  protect_from_forgery :only => [:create, :update, :destroy]
  before_filter :authenticate_user!,  :only => [:create, :update, :destroy, :show, :new, :index]
  
  # GET /payments
  # GET /payments.xml
  def index
    @payments = Payment.find_all_by_user_id(current_user.id).paginate(:page =>params[:page], :per_page => 9)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @payments }
    end
  end

  # GET /payments/1
  # GET /payments/1.xml
  def show
    @payment = Payment.find(params[:id])
    if  @payment.user_id != current_user.id  
      @payment = nil
      flash[:notice] = "Unable display. Not your payment?"
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @payment }
    end
  end

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
      when 'sig'
        @payment.payment_for = 'Signup'
        signup = Signup.find(params[:id])
        @payment.txn_amount = signup.paid_amt 
        @payment.member_id = signup.id
    end
    @payment.channel = "Web"
    @payment.user_id = current_user.id
    @payment.order_id =  params[:id]
    @payment.branch_id = 801 #remove hard coding
    @payment.state = "PrePayment"
    @payment.p_mode = 'Credit Card'
    @payment.fee = @payment.calc_conv_fee #15 #convinience fee
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
      if @payment.payment_for.eql?("Signup")
        @member = Signup.find(@payment.order_id)
      end
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
    
    @payment = Payment.find(order_Id)
    
    if @payment.verifyChecksum(checksum, authDesc) #and valid_request?
      case authDesc
        when "Y"
          @payment.state = "ConfirmPayment"
          @payment.details = "Thank you. Your credit card has been charged, your order will be executed shortly."
        when "B"
          @payment.state = "UnknownPayment"
          @payment.details = "Thank you. We will keep you posted regarding the status of your order through e-mail"
        when "N"
          @payment.state = "FailedPayment" #"ConfirmPayment" use for testing
          @payment.details = "Your transaction has been declined by the merchant. Please verify your details and retry."
      end
      if (@payment.save!)
        flash[:notice] = @payment.details
      else
        flash[:notice] = @payment.details + "Failed to record the payment. Please contact customer care."
      end
    else
      reset_session
      flash[:notice] = "The transaction could not be verified."
    end
    
    redirect_to(@payment)
  end
  
  def valid_request?
    #abc=""
    form_authenticity_token == params[:Merchant_Param] ||
    form_authenticity_token == request.headers['X-CSRF-Token']
    
    #logger.debug "RENU  check here "+ abc 
    #logger.debug "fat " + form_authenticity_token
    #logger.debug "session "+ session[:_csrf_token]
    #logger.debug "params " + params[:Merchant_Param]
    #logger.debug "header" + request.headers['X-CSRF-Token']
    #xyz = !protect_against_forgery? || request.get? ||
    #form_authenticity_token == params[:Merchant_Param] ||
    #form_authenticity_token == request.headers['X-CSRF-Token'] 
    #logger.debug xyz.to_s
    
    #abc.eql?("TRUE") ? true : false
    
  end

end
