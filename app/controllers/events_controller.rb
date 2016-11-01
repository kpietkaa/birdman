class EventsController < ApplicationController
  before_action :find_event, only: [ :show, :edit, :update, :destroy ]
  def index
    @events = Event.where(start_at: params[:start]..params[:end])
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.save
  end

  def edit
  end

  def update
    @event.update(event_params)
  end

  def destroy
    @event.destroy
  end

  private

  def event_params
    params.require(:event).permit(:title, :date_range, :start_at, :end_at, :event_type)
  end

  def find_event
    @event = Event.find(params[:id])
  end
end