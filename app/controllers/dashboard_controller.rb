class DashboardController < ApplicationController
  def index
    params = {:page=> 1, :per_page=>3 }
    @shelf0 = StarCategory.find_all_by_star_type('NA').paginate(:page=> params[:page], :per_page => params[:per_page])
    params = {:page=> 1, :per_page=>1 }
    @shelf1 = StarCategory.find_all_by_star_type('TT').paginate(:page=> params[:page], :per_page => params[:per_page])
    params = {:page=> 1, :per_page=>1}
    @myshelf = []
    myshelf = []
    if user_signed_in?
      user = current_user
      logger.info user
      user.member.each do |member|
        member.read_shelf.each do |rs|
          myshelf << rs
        end
      end
      @myshelf = myshelf.paginate(:page => 1, :per_page => 1)
    end
  end

end
