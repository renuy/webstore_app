class PlansController < ApplicationController

  def index
    @plans = Plan.all( :conditions => ['UPPER(public1) = ? AND UPPER(allow_renewal) = ? AND plan_type in (?)','YES','YES',['B','N','W','C']], :order => ('plan_type, cnt_books, cnt_magazine')) 
  end
end
