module MoviesHelper
  # give the link_to
  def sort_column_link(column, title=nil)
    link_to title, {:sort => column, :ratings => params[:ratings]}
  end
  
  def getThClass(column)
    params[:sort] == column ? "hilite" : nil
  end
  #constructs a check box tag
  #first item is the parameter set
  #second item is what it is set to
  #third item is if the check box should be checked
  #by default everything is checked if there are no ratings
  def getCheckBoxStatus(rating)
    
    checked = params[:ratings] == nil || params[:ratings][rating] != nil
    check_box_tag "ratings[#{rating}]" , 1, checked
  end
end
