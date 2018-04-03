class LendingsController < ApplicationController
  def create
    @lending = Lending.new(user_id: params[:lending][:user_id], item_id: params[:lending][:item_id], dead_line:params[:lending][:dead_line], is_lent:true)
    if @lending.save
      flash[:notice]="貸出が完了いたしました"
      redirect_to controller: 'home', action: 'index'
    else
      messages = ""
      @lending.errors.full_messages.each{ |msg| messages += "#{msg}¥n" }

      set_flash(:alert, messages)
      redirect_to  controller: 'home', action: 'index'
    end
  end

  def update
    @lending = Lending.find_by(item_id: params[:update][:item_id])
    if !@lending.is_renewed?
      @lending = @lending.update(dead_line_params)
      set_flash(:notice, "#{@lending.item.name}を#{@lending.dead_line}まで延長しました")
    else
      set_flash(:alert, "#{@lending.item.name}は延長できませんでした")
    end
    redirect_to controller: 'home', action: 'index'
  end

  def dead_line_params
    params.require(:update).permit(:dead_line)
  end

end
