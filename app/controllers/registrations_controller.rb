class RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!, :only=>[:add, :show]
  def new
    super
  end
  def create
    super
    #session[:omniauth] = nil unless @user.new_record?
  end

  def update
    super
  end
  
  def show
    @user = current_user  
  end
  
  def add 
    @user = User.new
    @parent = current_user
    @user.parent_id =  @parent.id
    #sign_out_all_scopes
    #redirect_to new_user_registration_path(:pk => params[:pk])
  end
  
  def kid
    
    @user = User.new(params[:user])
    
      if @user.save
        redirect_to(current_user_path(@user), :notice => 'kids profile was successfully created.')
      else
        @parent = current_user
        render 'add'
      end
    
  end
end 