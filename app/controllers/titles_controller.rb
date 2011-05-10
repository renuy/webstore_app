class TitlesController < ApplicationController
  def index
    newSearch = Sunspot.new_search(Title) do
      paginate(:page => params[:page], :per_page => 4)
      facet(:category_id, :publisher_id, :author_id)
    end
    
    search = Sunspot.new_search(Title) do
      paginate(:page => params[:page], :per_page => 6)
    end


    if !params[:queryTitleId].blank?
      if Title.exists?(params[:queryTitleId])
        @title = Title.find(params[:queryTitleId])
        if params[:query].blank?
          params[:query] = @title.title
        else
          params[:queryTitleId] = ""
        end
      end
    end
    
#    newSearch = Sunspot.new_search(Title) do
#      keywords params[:query] do
#        highlight :title, :publisher, :author
#      end
#      paginate(:page => params[:page], :per_page => 15)
#      facet(:category_id, :publisher_id, :author_id)
#    end
 
    newSearch.build do
      keywords params[:query] do
        highlight :title, :publisher, :author
      end
    end
    
    search.build do
      keywords(params[:query] )
    end
      
    search.build do
      order_by(:no_of_rented, :desc)
    end
    search.build do 
      with(:branch).any_of Title::BRANCH
    end
    newSearch.build do 
      with(:category_id, params[:facetCategory]) 
    end if params[:facetCategory].to_i > 0

    newSearch.build do 
      with(:publisher_id, params[:facetPublisher]) 
    end if params[:facetPublisher].to_i > 0

    newSearch.build do 
      with(:author_id, params[:facetAuthor]) 
    end if params[:facetAuthor].to_i > 0
    
    newSearch.build do 
      with(:branch).any_of Title::BRANCH
    end
    
    @searchResults = newSearch.execute
    @shelfMR = search.execute
    i = 0
    shelf0= @searchResults.facet(:category_id).rows
    @shelf_name = []
    @shelf_name << ""
    @shelf_name << ""
    @shelf_name << ""
    @shelf_name << ""
    
    #facetCategory
    @shelf  =[]
    @shelf << []
    @shelf << []
    @shelf << []
    @shelf << []
    @cat_id  =[]
    @cat_id <<  1
    @cat_id <<  2
    @cat_id <<  3
    @cat_id <<  4
    
    per_page = 1
    @shelf0= @searchResults.facet(:category_id).rows
    @shelf1 = @searchResults.facet(:author_id).rows.paginate(:page=> params[:page], :per_page=>2)
    @shelf3 = @searchResults.facet(:publisher_id).rows.paginate(:page=> params[:page], :per_page=>2)
    @shelf4 = @searchResults.results
    
    @shelf0.each do |row|  
      if i<4
        case i
          when 0 then per_page = 3
          when 1 then per_page = 1
          when 2 then per_page = 2
          when 3 then per_page = 1
        end
        @shelf_name[i] = row.instance.name
        @cat_id[i] = row.value
        cat_search = Sunspot.new_search(Title) do
          paginate(:page => params[:page], :per_page => per_page)
          facet(:category_id)
        end
        cat_search.build do 
          with(:category_id, row.value) 
        end 
        
        cat_search.build do
          keywords(params[:query] )
        end
        @shelf[i] = cat_search.execute  
        
      end
      i+=1
    end
    
    
    #@shelfMR = sr.results.paginate(:page=>1, :per_page=>5)
  end
  def refine
    
    search = Sunspot.new_search(Title) do
      paginate(:page => params[:page], :per_page => params[:per_page])
    end
    search.build do
      keywords(params[:query] )
    end
    
    search.build do 
      with(:category_id, params[:facetCategory]) 
    end if params[:facetCategory].to_i > 0
    search.build do 
      with(:category_id, params[:cat_id]) 
    end if params[:cat_id].to_i > 0

    search.build do
      order_by(:no_of_rented, :desc)
    end if params[:shelf].eql?('MOST READ')
    
    search.build do 
      with(:branch).any_of Title::BRANCH
    end
    shelfMR = search.execute
    
    @shelf0 = shelfMR.results
    
    @shelf_name=params[:shelf]
    render 'show'  
  end
  
# not using more like this- not sure how this is working as of now
  def show
    title = Title.find(params[:id])
    params[:query] = title.title
    
    
    params[:query] = title.title
    shelf0 = []
    shelf0 << title
    @shelf_name=  title.title
    
    newSearch = Sunspot.new_more_like_this(title, Title) do
      facet(:category_id, :publisher_id, :author_id)
    end
    
    newSearch.build do 
      with(:category_id, params[:cat_id]) 
    end if params[:cat_id].to_i > 0

    newSearch.build do 
      with(:publisher_id, params[:facetPublisher]) 
    end if params[:facetPublisher].to_i > 0

    newSearch.build do 
      with(:author_id, params[:facetAuthor]) 
    end if params[:facetAuthor].to_i > 0
    newSearch.build do 
      with(:branch).any_of Title::BRANCH
    end
    searchResults = newSearch.execute
    searchResults.results.each do |sr|
      shelf0 << sr
    end
    @shelf0  = shelf0.paginate(:page => params[:page], :per_page => 9)
#    @searchResults = Sunspot.more_like_this(@title, Title) do
#      fields :title, :publisher, :author
#      paginate(:page => params[:page], :per_page => 15)
#      facet(:category_id, :publisher_id, :author_id)
#    end
  end
  
  
  def favourite
    newSearch = Sunspot.new_search(Title) do
      paginate(:page => params[:page], :per_page => 4)
      facet(:category_id)
    end
   
    shelf0 = []
    if user_signed_in?
      u = User.find(current_user.id)
      shelf0 = u.favourite 
    end
    @shelf_name = ["","","","","","","","",""]
    @shelf  = [[],[],[],[],[],[],[],[],[]]
    @cat_id =  [ 1+rand(6), 26, 7+rand(6), 12+rand(6), 17+rand(6),   22+rand(5), 27+rand(7), 34+rand(6), 41 ]
    per_page = 1
    x = shelf0.size > 9 ? 9 : shelf0.size 
    idx = 0
    
    x.times do  
        case idx
          when 0 then per_page = 3
          when 1 then per_page = 2
          when 2 then per_page = 2
          when 3 then per_page = 2
          when 4 then per_page = 2
          when 5 then per_page = 3
          when 6 then per_page = 3
          when 7 then per_page = 2
          when 8 then per_page = 2
          
          
        end
        @shelf_name[idx] = shelf0[idx].category.name
        @cat_id[idx] = shelf0[idx].category.id
        cat_search = Sunspot.new_search(Title) do
          paginate(:page => params[:page], :per_page => per_page)
          facet(:category_id)
        end
        cat_search.build do 
          with(:category_id, shelf0[idx].category.id) 
        end 
        cat_search.build do
          keywords(params[:query] )
        end
        cat_search.build do 
          with(:branch).any_of Title::BRANCH
        end
        @shelf[idx] = cat_search.execute  
        
      idx+=1
      
    end
    
    x = 9 - idx 
    x.times do 
      case idx
        when 0 then per_page = 3
        when 1 then per_page = 2
        when 2 then per_page = 2
        when 3 then per_page = 2
        when 4 then per_page = 2
        when 5 then per_page = 3
        when 6 then per_page = 3
        when 7 then per_page = 2
        when 8 then per_page = 2
         
      end
        cat = Category.find(@cat_id[idx])
        @shelf_name[idx] = cat.name
        
        cat_search = Sunspot.new_search(Title) do
          paginate(:page => params[:page], :per_page => per_page)
          facet(:category_id)
        end
        cat_search.build do 
          with(:category_id, cat.id) 
        end 
        cat_search.build do 
          with(:branch).any_of Title::BRANCH
        end
        cat_search.build do
          keywords(params[:query] )
        end
        @shelf[idx] = cat_search.execute  
      idx+=1
    end
    #@shelfMR = sr.results.paginate(:page=>1, :per_page=>5)
  end

end
