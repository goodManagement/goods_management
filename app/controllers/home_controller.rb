class HomeController < ApplicationController
  # ユーザがログインしていないと"show"にアクセスできないようにする
  before_action :authenticate_user!

  def index
    p flash
    @lendings = current_user.current_lendings
    render :index, layout: "application_with_navbar"
  end

  # 物品の返却をする
  def return_item
    lending = Lending.search_with_id(params[:lending_id])
    lending
    if lending.return_item
      flash[:success] = "返却が完了しました"
    else
      set_flash(:danger, "返却時にエラーが生じました")
    end
    # redirect_to "/home/index"と同義 /home/indexにリダイレクトする
    redirect_to controller: :home, action: :index
  end

  # 物品の返却期限を延長する
  def renew_item
   item =Item.find_by(id: params[:item_id])
   if item.lending.is_renewed?
     item.lending.renew_item
   end
   redirect_to("/home/index")
 end

end
