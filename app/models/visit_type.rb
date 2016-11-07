class VisitType < ActiveRecord::Base
  has_many :events

  def visit
    self.title + ' | Price: ' + self.price.to_s
  end
end
