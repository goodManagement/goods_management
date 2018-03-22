class HomeController < ApplicationController
  # ユーザがログインしていないと"show"にアクセスできないようにする
  before_action :authenticate_user!

  def index
    @lendings = []
    30.times do |i|
      lending = Lending.new(user_id: i, item_id: i, dead_line:Time.now)

      @lendings.push(lending)

    end
    render :index, layout: "application_with_navbar"
  end

  def back
    item =Item.find_by(serial_number: params[:id])
    item.return_item
    redirect_to("/home/index")
  end



end
