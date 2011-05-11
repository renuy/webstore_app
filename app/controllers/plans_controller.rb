class PlansController < ApplicationController

  def index
    branch = Branch.find(Title::BRANCH[0].to_i)
    
    @plans = branch.plans.find(:all, :conditions => ['UPPER(allow_renewal) = ? AND plan_type in (?)','YES',['B','N','W','C']], :order => ('plan_type, cnt_books, cnt_magazine'))
    #@plans = Plan.all( :conditions => ['UPPER(public1) = ? AND UPPER(allow_renewal) = ? AND plan_type in (?)','YES','YES',['B','N','W','C']], :order => ('plan_type, cnt_books, cnt_magazine')) 
  end
end
