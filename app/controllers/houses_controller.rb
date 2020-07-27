class HousesController < ApplicationController
  before_action :set_house, only: [:show, :update, :destroy]
  before_action :authenticate_user, only: [:create]

  def index
    @houses = House.all
    json_response(@houses)
  end

  def create
    @house = current_user.houses.build(house_params)
    if @house.save
      json_response(@house, :created)
    else
      json_response(@house, :unprocessable_entity)
    end
  end

  def show
    json_response(@house)
  end

  def update
    @house.update(house_params)
    head :no_content
  end

  def destroy
    @house.destroy
    head :no_content
  end

  private

  def house_params
    params.permit(:name, :description, :price)
  end

  def set_house
    @house = House.find(params[:id])
  end
end
