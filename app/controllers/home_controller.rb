class HomeController < ApplicationController
  # ユーザがログインしていないと"show"にアクセスできないようにする
  before_action :authenticate_user!

  def index
    @lendings = current_user.current_lendings
    render :index, layout: "application_with_navbar"
  end

  def back
    item =Item.find_by(serial_number: params[:id])
    item.return_item
    # redirect_to "/home/index"と同義 /home/indexにリダイレクトする
    redirect_to controller: :home, action: :index
  end

end
