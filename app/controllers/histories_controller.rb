class HistoriesController < ApplicationController
  load_and_authorize_resource
  before_action :find_event, only: [:show, :new, :create, :edit ]
  before_action :find_data, only: [ :show, :new, :edit ]
  before_action :create_event, only: [ :show, :new, :edit ]
  before_action :find_history, only: [ :show, :edit, :update ]
  def index
  end

  def show
  end

  def new
    @history = History.new
  end

  def create
    @history ||= History.new(history_params)
    @history.event_id = @event.id
    @history.save
    @event.update_attribute(:history_id, @history.id)
    if @history.errors.any?
      render 'new'
    else
      redirect_to root_path, notice: 'History has been created'
    end
  end

  def edit
  end

  def update
    @history.update(history_params)
    if @history.errors.any?
      render 'edit'
    else
      redirect_to root_path, notice: 'History has been updated'
    end
  end

  private
  def history_params
    params[:history].permit(:description, :surgery, :recipe)
  end

  def find_event
    @event ||= Event.find(params[:event_id])
  end

  def find_data
    @animal_info ||= Animal.find(@event.animal_id)
    @owner_info ||= User.find(@event.user_id)
    @owner_address ||= Address.find(@owner_info.address_id)
  end

  def find_history
    @history ||= History.find(params[:id])
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
