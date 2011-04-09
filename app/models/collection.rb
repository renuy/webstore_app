class Collection < ActiveRecord::Base
 
  
  scope :for_home_page, lambda {|col_name_id|
      {
        :conditions => ['collection_name_id >= ?',col_name_id]
      }
    }
  belongs_to :title, :class_name => "Title" , :foreign_key => "titles_id"
  
  belongs_to :series, :class_name => "Series", :foreign_key => "series_id"
  
  belongs_to :collection_names, :class_name => "CollectionName", :foreign_key =>"collection_name_id"
  
  def self.for_home_page(params) 
    paginate :page => params[:page], :per_page=> params[:per_page], :conditions => ['collection_name_id = ?',params[:cnameid]]
  end
end
