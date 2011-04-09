class MyshelfController < ApplicationController
before_filter :authenticate_user!

  def index
    @rs = []
    @rns = []
    @rnsd = []
    user = current_user
    user.member.each do |member|
      member.read_shelf.each do |rs|
        @rs << rs
      end
      member.read_next_shelf.each do |rns|
        @rns << rns unless rns.status.eql?('D')
        @rnsd << rns if rns.status.eql?('D')
      end
    end
    @shelf0 = @rs.paginate(:page => 1, :per_page => 3)
    @shelf1 = @rnsd.paginate(:page => 1, :per_page => 2)
    @shelf2 = @rns.paginate(:page => 1, :per_page => 2)
    @shelf3 = [].paginate(:page => 1, :per_page => 2)
    @shelf4 = [].paginate(:page => 1, :per_page => 2)
    @shelf5 =[].paginate(:page => 1, :per_page => 3)
    @shelf6 =[].paginate(:page => 1, :per_page => 3)
    @shelf7 =[].paginate(:page => 1, :per_page => 2)
    @shelf8 =[].paginate(:page => 1, :per_page => 2)
  end
  
  def show
    params1 = {:page=> params[:page], :per_page=>params[:per_page]}
    @shelf = []
    @shelf_name = ""
    @rs = []
    @rns = []
    @rnsd = []
    user = current_user
    user.member.each do |member|
      member.read_shelf.each do |rs|
        @rs << rs
      end
      member.read_next_shelf.each do |rns|
        @rns << rns unless rns.status.eql?('D')
        @rnsd << rns if rns.status.eql?('D')
      end
    end
      if params[:shelf].eql?('rs') 
          @shelf = @rs
          @shelf_name = 'READ'
      end  
      if params[:shelf].eql?('rnsd') 
          @shelf = @rnsd
          @shelf_name = 'READING'
      end
      if params[:shelf].eql?('rns') 
          @shelf = @rns
          @shelf_name = 'BOOKMARKED'
      end
    @shelf0 = @shelf.paginate(:page => params[:page], :per_page=> params[:per_page])
  end
end
