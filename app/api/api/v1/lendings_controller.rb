class Api::V1::LendingsController < ApplicationController

  def create
    @lending = Lending.new(user_id: params[:lending][:user_id], item_id: params[:lending][:item_id], dead_line:params[:lending][:dead_line], is_lent:true)
    if @lending.save
      flash[:notice]="貸出が完了いたしました"
      redirect_to controller: 'home', action: 'index'
    else
      messages = ""
      @lending.errors.full_messages.each{ |msg| messages += "#{msg}¥n" }

      set_flash(:alert, messages)
      redirect_to  controller: 'items', action: 'index'
    end
  end

  def update
    @lending = Lending.search_with_id(params[:update][:lending_id])
    if !@lending.is_renewed?
      @lending.update(dead_line_params)

      set_flash(:notice, "#{@lending.item.name}を#{@lending.dead_line}まで延長しました")
    else
      set_flash(:alert, "#{@lending.item.name}はすでに一度延長されています")
    end
    redirect_to controller: 'home', action: 'index'
  end

  def dead_line_params
    params.require(:update).permit(:dead_line)
  end

  # 物品の返却をする
  def return_item
    lending = Lending.search_with_id(params[:lending_id])
    lending
    if lending.return_item
      set_flash(:success, "返却が完了しました")
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

  def index
    p flash
    @lendings = current_user.current_lendings
    render :index, layout: "application_with_navbar"
  end

end
