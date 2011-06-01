class PlansController < ApplicationController

  def index
    if Title::BRANCH.include?(params[:b])
      @branch = Branch.find(params[:b].to_i)
    else 
      @branch = Branch.find(Title::BRANCH[0].to_i)
    end
    branch = Branch.find(Title::BRANCH[0].to_i)
    @plans = branch.plans.find(:all, :conditions => ['UPPER(allow_renewal) = ? AND plan_type in (?)','YES',['B','N','W','C']], :order => ('plan_type, cnt_books, cnt_magazine')).paginate(:page=>params[:page],:per_page=>3)
    #@plans = Plan.all( :conditions => ['UPPER(public1) = ? AND UPPER(allow_renewal) = ? AND plan_type in (?)','YES','YES',['B','N','W','C']], :order => ('plan_type, cnt_books, cnt_magazine')) 
  end
end
