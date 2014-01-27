class Score < ActiveRecord::Base

  def where_top 
    order("#{table_name}.score DESC")
    .limit(10)
  end
end
