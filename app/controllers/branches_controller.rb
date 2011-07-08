class BranchesController < ApplicationController
  def show
    @branch = Branch.find(params[:id])
  end

  def index
    
    render 'index', :layout => 'corp'
      
  end
end
