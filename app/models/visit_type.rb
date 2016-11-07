class VisitType < ActiveRecord::Base
  has_many :events

  def visit
    self.name + 'Price: ' + self.price
  end
end
