class HistoriesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
    @event = Event.find(params[:event_id])
    @animal_info = Animal.find(@event.animal_id)
    @owner_info = User.find(@event.user_id)
    @owner_address = Address.find(@owner_info.address_id)
    create_event
    @history = History.find(params[:id])
  end


  def new
    @event = Event.find(params[:event_id])
    @animal_info = Animal.find(@event.animal_id)
    @owner_info = User.find(@event.user_id)
    @owner_address = Address.find(@owner_info.address_id)
    create_event
    @history = History.new
  end

  def create
    @event = Event.find(params[:event_id])
    @history = History.new(history_params)
    @history.event_id = @event.id
    @history.save
    @event.update_attribute(:history_id, @history.id)
    if @history.errors.any?
      render 'new'
    else
      redirect_to root_path
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @animal_info = Animal.find(@event.animal_id)
    @owner_info = User.find(@event.user_id)
    @owner_address = Address.find(@owner_info.address_id)
    create_event
    @history = History.find(params[:id])
  end

  def update
    @history = History.find(params[:id])
    @history.update(history_params)
    if @history.errors.any?
      render 'edit'
    else
      redirect_to root_path
    end
  end

  private
  def history_params
    params[:history].permit(:description, :surgery, :recipe)
  end

  def create_event
    visit_hash = Hash[VisitType.all.map{ |v| [v.title, v.color] }]
    animals_hash = Hash[Animal.all.map{ |a| [[a.name, a.id], a.id ] }]
    animal_owner = Hash[User.all.map{ |u| [ u.full_name, u.id ] }]
    @event.event_type = visit_hash.key(@event.event_type)
    @event.animal_name = animals_hash.key(@event.animal_id)[0]
    @event.owner_name = animal_owner.key(@event.user_id)
  end
end
