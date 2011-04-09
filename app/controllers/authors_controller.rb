class AuthorsController < ApplicationController  
  def index
    @authors = Author.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 10, :page => params[:page])
  end
  
  def edit
    @author = Author.find(params[:id])
  end
  
  def show
    @author = Author.find(params[:id])
    
    respond_to do |format|
      format.html { render }
      format.js { render }
    end
  end
  
  def update
    @author = Author.find(params[:id])
    
    respond_to do |format|
      if @author.update_attributes(params[:author])
        format.html {redirect_to(@author, :notice => 'Item was successfully updated.')}
        format.js 
          flash[:notice] = 'Item was successfully updated.'
          render :action => 'show'
          return
      else
        format.html {render :action => 'edit'}
        format.js {render :action => 'edit'}
      end
    end
  end
  
  private 
  
  def sort_column
    Author.column_names.include?(params[:sort]) ? params[:sort] : 'name'
  end 
  
  def sort_direction
    %w[asc desc].include?(params[:sortdir]) ? params[:sortdir] : 'asc'
  end
end
