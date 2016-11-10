class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :vist_type
  validates :title, presence: true
  attr_accessor :date_range, :doctor_name, :animal_name, :owner_name

  def all_day_event?
    self.start_at == self.start_at.midnight && self.end_at == self.end_at.midnight ? true : false
  end

  def completed?
    !completed_at.blank?
  end
end
