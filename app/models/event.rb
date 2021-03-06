class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :vist_type
  has_many :histories
  validates :event_type, :doctor_id, :animal_id, presence: true
  attr_accessor :date_range, :doctor_name, :animal_name, :owner_name

  def all_day_event?
    self.start_at == self.start_at.midnight && self.end_at == self.end_at.midnight ? true : false
  end

  def completed?
    !completed_at.blank?
  end

  def self.type_sort(type)
    includes(:user).where("event_type LIKE ?", type).order("start_at")
  end
end
