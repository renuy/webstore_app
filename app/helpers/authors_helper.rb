module AuthorsHelper
  def sort_column
    Author.column_names.include?(params[:sort]) ? params[:sort] : 'name'
  end 
  
  def sort_direction
    %w[asc desc].include?(params[:sortdir]) ? params[:sortdir] : 'asc'
  end
end
