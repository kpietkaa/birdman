class AnimalsController < ApplicationController
  before_action :find_animal, only: [:show, :edit, :update, :destroy]
  def index
  end

  def show
  end

  def new
    @animal = Animal.new
  end

  def create
    @animal = Animal.new(animal_params)
    if @animal.save
      redirect_to @animal, notice: 'Animal has been created'
    else
      render 'new'
    end
  end

  def edit
    @animals = Animal.animal_types.map{ |key, val| [ key.split('_').first.capitalize, key ] }
  end

  def update
    if @animal.update(animal_params)
      redirect_to @animal, notice: 'Animal has been updated'
    else
      render 'edit'
    end
  end

  private

  def animal_params
    params.require(:animal).permit(:name, :animal_type, :breed, :sex, :castration, :birth_date)
  end

  def find_animal
    @animal = Animal.find(params[:id])
  end
end
