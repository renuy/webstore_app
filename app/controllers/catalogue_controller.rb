class CatalogueController < ApplicationController

  def index
    @shelves = CollectionName.find(:all) 
    params = {:page=> 1, :per_page=>3, :cnameid => @shelves[0].id}
    @shelf0 = Collection.for_home_page(params)
    params = {:page=> 1, :per_page=>2, :cnameid => @shelves[1].id}
    @shelf1 = Collection.for_home_page(params)  
    params = {:page=> 1, :per_page=>2, :cnameid => @shelves[2].id}
    @shelf2 = Collection.for_home_page(params)  
    params = {:page=> 1, :per_page=>2, :cnameid => @shelves[3].id}
    @shelf3 = Collection.for_home_page(params)  
    params = {:page=> 1, :per_page=>3, :cnameid => @shelves[4].id}
    @shelf4 = Collection.for_home_page(params)  
    params = {:page=> 1, :per_page=>2, :cnameid => @shelves[5].id}
    @shelf5 = Collection.for_home_page(params)  
    params = {:page=> 1, :per_page=>2, :cnameid => @shelves[6].id}
    @shelf6 = Collection.for_home_page(params)  
    params = {:page=> 1, :per_page=>2, :cnameid => @shelves[7].id}
    @shelf7 = Collection.for_home_page(params)  
    params = {:page=> 1, :per_page=>3, :cnameid => @shelves[8].id}
    @shelf8 = Collection.for_home_page(params)  
    
  end  
  
end
