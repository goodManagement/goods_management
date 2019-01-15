class Api::V1::ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
    @user = User.find(params[:email])
  end

end
