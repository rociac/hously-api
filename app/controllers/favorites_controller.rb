class FavoritesController < ApplicationController
  before_action :authenticate_user
  before_action :set_house, only: [:create, :destroy]
  before_action :already_favorite?, only: :create

  def index
    @favorites = Favorite.where(user_id: current_user.id)
    @full_favorites = []
    @favorites.each do |favorite|
      @houses = House.where(id: favorite.house_id)
      @houses.each do |house|
        @full_favorites.push(house)
      end
    end
    json_response(@favorites)
  end

  def favorited
    favorited = Favorite.where(user_id: current_user.id, house_id: params[:house_id]).exists?
    json_response(favorited)
  end
  
  def create
    @favorite = current_user.favorites.build(user_id: current_user.id, house_id: @house.id)
    if already_favorite?
      json_response({ msg: "Already in favorites"}, :unprocessable_entity)
    else
      if @favorite.save
        json_response(@favorite, :created)
      else
        json_response(@favorite, :unprocessable_entity)
      end
    end
  end

  def destroy
    @favorite = Favorite.where(user_id: current_user.id, house_id: @house.id).first
    if !already_favorite?
      json_response({ msg: "Cannot remove from favorites"})
    else
      @favorite.destroy
      json_response({ msg: "Removed from favorites"})
    end
  end

  private

  def set_house
    @house = House.find(params[:house_id])
  end

  def already_favorite?
    Favorite.where(user_id: current_user.id, house_id: params[:house_id]).exists?
  end
end
