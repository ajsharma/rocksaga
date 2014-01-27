class Score < ActiveRecord::Base

  attr_accessible :name, :score

  validates_presence_of :name
  validates_presence_of :score

  def self.where_best
    order("#{table_name}.score DESC")
    .limit(10)
  end

end
