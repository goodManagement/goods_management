class HomeController < ApplicationController
  # ユーザがログインしていないと"show"にアクセスできない
  before_action :authenticate_user!

  def index
    @lendings = []
    30.times do |i|
      lending = Lending.new(user_id: 100+i, item_id: 200+i, dead_line:Time.now)

      @lendings.push(lending)

    end


    render :index, layout: "application_with_navbar"
  end


  def back
    lendings =Lending.find_by(item_id: params[:id])
    lendings.is_lent=false
    lendings.save
    redirect_to("/home/index")
  end

end
