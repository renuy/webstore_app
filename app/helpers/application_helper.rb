module ApplicationHelper
  def title
    base_title = "Strata Retail - Just Books Community Library Chain"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end  
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    sortdir = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :sortdir => sortdir, :page => nil), {:class => css_class}
  end
  
  def image_url(titleId)
    if titleId then
      "http://justbooksclc.com/images#{titleId/10000}/titles#{titleId/10000}/#{titleId}.jpg"
    else
      "#"
    end
  end
  
  def default_image_url
    "http://justbooksclc.com/images/noimage.jpg"
  end
  
end
