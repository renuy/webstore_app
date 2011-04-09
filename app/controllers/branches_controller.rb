class BranchesController < ApplicationController
  def show
    @branch = Branch.find(params[:id])
  end

  def index
    if params[:card_id].blank?
      @branches = Branch.all
      respond_to do |format|
        format.html { }
        format.xml  { render :xml => @branches }
      end
    else
      @branch = Branch.find_by_card_id(params[:card_id])
      respond_to do |format|
        if @branch.nil?
          format.html { redirect_to branches_path }
          format.xml  { render :xml => @branch }
        else
          format.html { render :show unless @branch.nil? }
          format.xml  { render :xml => @branch }
        end
      end
    end
  end
end
