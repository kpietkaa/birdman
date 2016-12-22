class EventsController < ApplicationController
  load_and_authorize_resource
  before_action :find_event, only: [ :show, :edit, :update, :destroy, :complete ]
  before_action :find_doctor, only: [ :new, :edit ]
  before_action :find_animal, only: [ :new, :edit ]
  before_action :map_visit_type, only: [ :new, :edit, :create, :update ]
  def index
    @events = Event.where(start_at: params[:start]..params[:end])
  end

  def show
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
    change_range_to_date
    right_time_to_event
    time_validator
  end

  def edit
  end

  def update
    @event.update(event_params)
    change_range_to_date
    right_time_to_event
    time_validator
  end

  def destroy
    @event.destroy
    redirect_to root_path, notice: 'Vist has been deleted'
  end

  def complete
    @event.update_attribute(:completed_at, Time.now)
    redirect_to root_path, notice: 'Vist has been completed :)'
  end

  def current_user_role
    render json: {role: current_user.role}
  end

  private

  def event_params
    params.require(:event).permit(:date_range, :start_at, :end_at, :event_type, :doctor_id, :animal_id)
  end

  def find_event
    @event ||= Event.find(params[:id])
  end

  def change_range_to_date
    @event.start_at = @event.date_range.tr('/','-').split(' - ')[0]
    @event.end_at = @event.date_range.tr('/','-').split(' - ')[1]
  end

  def time_validator
    unless weekend?
      if @event.start_at.hour < 9 || @event.start_at.hour > 18
        time_alert
      elsif @event.end_at.hour > 18
        time_alert
      elsif @event.end_at.hour == 18 && @event.end_at.hour > 0
        time_alert
      else
        @event.save
      end
    else
      redirect_to :back, alert: 'We are close on Saturdays and Sundays :)'
    end
  end

  def weekend?
    @event.start_at.saturday? || @event.start_at.sunday?
  end

  def time_alert
    redirect_to :back, alert: 'We are closed at that time , Please select other time , 9 to 17 :)'
  end

  def find_doctor
    @doctors = User.all.select{|u| u.role=='doctor' }.map{ |u| [ u.full_name, u.id ] }
  end

  def find_animal
    @animals = Animal.all.select{ |a| a.user_id == current_user.id}.map{ |a| [ a.name, a.id ] }
  end

  def map_visit_type
    @visit_types = VisitType.all.map { |v| [ v.visit, v.duration, v.color ] }
  end

  def right_time_to_event
    unless @event.event_type.empty?
      duration = @visit_types.select{ |v| v[2] == @event.event_type }[0][1]
      @event.end_at = @event.start_at + duration*60
    end
  end
end
