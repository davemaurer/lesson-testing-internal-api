class Api::V1::ItemsController < ApplicationController
  respond_to :json

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find_by(params[:id])
  end

  def create
    # use location: nil to ignore url location
    respond_with  Item.create(item_params), location: nil
  end

  private

  def item_params
    params.require(:item).permit(:name, :description)
  end
end
