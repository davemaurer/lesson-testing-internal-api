class Api::V1::UsersController < ApplicationController
  respond_to :json

  def index
    respond_with User.all
  end

  def show
    respond_with User.find_by(params[:id])
  end

  def create
    # use location: nil to ignore url location
    respond_with User.create(user_params), location: nil
  end

  def update
    respond_with User.update(params[:id], user_params)
  end

  def destroy
    respond_with User.destroy(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
