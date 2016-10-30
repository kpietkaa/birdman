class AnimalsController < ApplicationController
  def index
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


  private

  def animal_params
    params.require(:animal).permit(:name, :animal_type, :breed, :sex, :castration, :birth_date)
  end
end
