module ApplicationHelper
  # Return a title on a per-page basis.
  def title
    base_title = "MyChi"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo  
    logo = image_tag("chi1.jpg", :alt => "MyChi", :class => "round") 

   # logo = image_tag("rails.png", :alt => "MyChi", :class => "round") 
  end

end