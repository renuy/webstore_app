class PlansController < ApplicationController

  def index
    if params[:b].nil? 
      params[:b] = "1"
    end
    @branch = Branch.find(params[:b].to_i)
    
    @plans = @branch.plans.find(:all, :conditions => ['upper(public1)=? AND id!= 26 AND UPPER(allow_renewal) = ? AND plan_type in (?)','YES','YES',['B','N','W']], :order => ('plan_type, cnt_books, cnt_magazine')).paginate(:page=>params[:page],:per_page=>3)
    #@plans = Plan.all( :conditions => ['UPPER(public1) = ? AND UPPER(allow_renewal) = ? AND plan_type in (?)','YES','YES',['B','N','W','C']], :order => ('plan_type, cnt_books, cnt_magazine')) 
  end
end
