class Task < ActiveRecord::Base
  belongs_to :city

  def capitalized_city_name
    self.city.name.capitalize
  end
end
