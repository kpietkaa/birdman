class AnimalsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :find_animal, only: [:show, :edit, :update, :destroy]
  before_action :animal_type_map, only: [:new, :edit]
  def index
    @animals = Animal.where(user_id: current_user.id).order("created_at DESC")
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
    @animal = Animal.where(user_id: current_user.id).find(params[:id])
  end

  def animal_type_map
    @animals = Animal.animal_types.map{ |key, val| [
      key.capitalize.tr('_', ' '), key ] }
  end
end
