class SignupsController < ApplicationController
  before_filter :authenticate_user!

  # GET /signups
  # GET /signups.xml
  def index
    @signups = Signup.find(:all, :conditions => ['email = ?', current_user.email])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @signups }
    end
  end

  # GET /signups/1
  # GET /signups/1.xml
  def show
    @signup = Signup.find(params[:id])
    if @signup.email.eql?(current_user.email) 
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @signup }
      end
    else
      redirect_to signups_path
    end
  end

  def new
    signUpMonths = 1
    @plan = Plan.find(params[:p])
    signUpMonths = params[:m].to_i unless params[:m].empty?
    
    if signUpMonths < 1 && @plan.subscription
      redirect_to :plans
    end

    @signup = Signup.new
    @signup.plan_id = @plan.id
    @signup.signup_months = signUpMonths
    @signup.email = current_user.email
    @signup.name = current_user.username
    if (@plan.subscription)
      @signup.security_deposit = @plan.sec_dep
      @signup.registration_fee = @plan.registration_fee
      @signup.reading_fee = @plan.renewAmount(signUpMonths)
      @signup.paid_amt = @plan.sec_dep + @plan.registration_fee + @plan.renewAmount(signUpMonths)
    else
      @signup.security_deposit = @plan.ppb_sec_dep(signUpMonths)
      @signup.registration_fee = @plan.registration_fee
      @signup.reading_fee = @plan.ppb_read_fee(signUpMonths)
      @signup.paid_amt = @plan.ppb_amount(signUpMonths) + @plan.registration_fee 
    end
    @signup.discount = 0
    @signup.overdue_amt = 0
  end
  
  def create
    
    @signup = Signup.new(params[:signup]) do |q|
      q.created_by = current_user.id
      q.modified_by = current_user.id
      q.membership_no = 'T'+"%010d" % Time.now.to_i
      q.payment_mode = 2
      # this does not look to be the best way to work with virtual attributes..
      q.payment_ref = 'Card'
      q.state = 'New'
    end
    @plan = Plan.find(@signup.plan_id)
    if @signup.save      
      #redirect_to(@signup, :notice => 'Member Signed Up Successfully')
      #SignupMailer.registration_confirmation(@signup).deliver
      redirect_to :action=>"new", :controller=>"payments", :id => @signup.id,:for=>'sig'
    else
      render :action => "new"
    end
        
  end

  
  def compute
    @plan = Plan.find(params[:plan_id])

    render :partial => 'payment', :locals => { :plan => @plan, :signup_months => params[:signup_months].to_i, :coupon_id => params[:coupon_id].to_i }
  end

  def newMemberReversal
    signup_id = params[:signup_id].to_i
    @signup = Signup.find(signup_id)

    if @signup.update_attributes(:flag_reversed => "Y",
        :reversal_reason_id => params[:reversal_reason].to_i,
        :updated_at => Time.zone.today)
      @reportMsg = 'New Member Reversal done for : ' + @signup.membership_no
    else
      @reportMsg = 'New Member Reversal failed for : ' + @signup.membership_no
    end

    render :partial => 'signup_msg'
  end

  def reSendWelcomeMail
    signup = Signup.find(params[:signup_id])
    SignupMailer.registration_confirmation(signup).deliver
    @reportMsg = 'Welcome Mail Re-Sent to - ' + signup.membership_no

    render :partial => 'signup_msg'
  end

  def rePrintReceipt
    @signup = Signup.find(params[:signup_id])

    render :partial => 'reprint_receipt'
  end

  def signups_link
    @sg = Signup.find(params[:signup_id].to_i)
    @card = Card.find_by_membership_no(@sg.membership_no)

    render :partial => 'signup_links'
  end

end
