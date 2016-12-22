class AnimalsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :find_animal, only: [:show, :edit, :update, :destroy]
  before_action :animal_type_map, only: [:new, :create, :edit]
  def index
    create_events
    @patients = Hash[@events.map{ |e| [e.id, e.animal_id] } ]

    if current_user.role == 'user'
      @animals = Animal.where(user_id: current_user.id).order("created_at DESC")
    else
      @animals = Animal.where(id: @patients.values)
    end
  end

  def show
  end

  def new
    @animal = current_user.animals.build
  end

  def create
    @animal = current_user.animals.build(animal_params)
    if @animal.save
      redirect_to @animal, notice: 'Animal has been created'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @animal.update(animal_params)
      redirect_to @animal, notice: 'Animal has been updated'
    else
      render 'edit'
    end
  end

  def destroy
    if @animal.destroy
      redirect_to animals_path, notice: 'Animal has been deleted'
    end
  end

  private

  def animal_params
    params.require(:animal).permit(:name, :animal_type, :breed,
      :sex, :castration, :birth_date)
  end

  def find_animal
    @animal ||= Animal.find(params[:id])
  end

  def animal_type_map
    @animals = Animal.animal_types.map{ |key, val| [
      key.capitalize.tr('_', ' '), key ] }
  end

  def create_events
    visit_hash = Hash[VisitType.all.map{ |v| [v.title, v.color] }]
    doctor_hash = Hash[User.all.select{|u| u.role=='doctor' }.map{ |u| [ u.full_name, u.id ] }]
    animal_hash = Hash[Animal.all.select{ |a| a.user_id == current_user.id}.map{ |a| [ a.name, a.id ] }]
    animals_hash = Hash[Animal.all.map{ |a| [ [a.name, a.id], a.id ] }]
    animal_owner = Hash[User.all.map{ |u| [ u.full_name, u.id ] }]
    
    @events = Event.all.order("start_at").select{ |e|
      if current_user.role == 'doctor' && e.doctor_id == current_user.id && e.start_at.strftime('%d%m%Y') == Time.now.strftime('%d%m%Y')
        e.event_type = visit_hash.key(e.event_type)
        e.animal_name = animals_hash.key(e.animal_id)[0]
        e.owner_name = animal_owner.key(e.user_id)
      elsif e.user_id == current_user.id && e.start_at > Time.now - 12.hours
        e.event_type = visit_hash.key(e.event_type)
        e.doctor_name = doctor_hash.key(e.doctor_id)
        e.animal_name = animal_hash.key(e.animal_id)
      end
    }
  end
end
