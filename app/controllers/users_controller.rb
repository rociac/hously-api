class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_user, only: [:index, :current, :update]

  def index
    @users = User.all
    protected_users = []
    @users.each do |user|
      temp_user = { id: user.id, name: user.name, email: user.email, avatar: user.avatar }
      protected_users.push(temp_user)
    end
    render json: protected_users
  end

  def current
    render json: { id: current_user.id, name: current_user.name, email: current_user.email, avatar: current_user.avatar }
  end

  def show
    render json: { id: @user.id, name: @user.name, email: @user.email, avatar: @user.avatar}
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:name, :email, :password, :password_confirmation, :avatar)
    end
end
