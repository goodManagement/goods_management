class Api::V1::LendingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @lending = Lending.new(user_id: params[:lending][:user_id], item_id: params[:lending][:item_id], dead_line:params[:lending][:dead_line], is_lent:true)
  end

  def update
    @lending = Lending.search_with_id(params[:update][:lending_id])
    if !@lending.is_renewed?
      @lending.update(dead_line_params)
    end
  end

  def dead_line_params
    params.require(:update).permit(:dead_line)
  end

  # 物品の返却をする
  def return_item
    lending = Lending.search_with_id(params[:lending_id])
    lending
  end

  # 物品の返却期限を延長する
  def renew_item
   item =Item.find_by(id: params[:item_id])
   if item.lending.is_renewed?
     item.lending.renew_item
   end
  end

  def index
    p flash
    @lendings = current_user.current_lendings
  end

end
