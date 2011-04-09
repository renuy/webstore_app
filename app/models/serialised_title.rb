class SerialisedTitle < ActiveRecord::Base
  belongs_to :series, :class_name => "Series", :foreign_key => "series_id"
  belongs_to :title, :class_name => "Title" , :foreign_key => "titles_id"
end
