class EventsController < ApplicationController
  before_action :find_event, only: [ :show, :edit, :update, :destroy ]
  def index
    @events = Event.where(start_at: params[:start]..params[:end])
  end

  def show
  end

  def new
    @event = current_user.events.build
    authorize! :new, @event
  end

  def create
    @event = current_user.events.build(event_params)
    change_range_to_date
    @event.save
  end

  def edit
  end

  def update
    @event.update(event_params)
    change_range_to_date
    @event.save
  end

  def destroy
    @event.destroy
  end

  private

  def event_params
    params.require(:event).permit(:title, :date_range, :start_at, :end_at, :event_type)
  end

  def find_event
    unless current_user.role == 'admin'
      @event = Event.where(user_id: current_user.id).find(params[:id])
    else
      @event = Event.find(params[:id])
    end
  end

  def change_range_to_date
    @event.start_at = @event.date_range.tr('/','-').split(' - ')[0]
    @event.end_at = @event.date_range.tr('/','-').split(' - ')[1]
  end
end
