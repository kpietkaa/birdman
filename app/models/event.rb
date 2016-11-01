class Event < ActiveRecord::Base
  validates :title, presence: true
  attr_accesor :date_range

  def all_day_event?
    self.start_at == selft.start_at.midnight && self.end_at == self.end_at.midnight ? true : false
  end
end
