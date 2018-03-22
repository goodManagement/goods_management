class LendingsController < ApplicationController
  def create
    @lending = Lending.new(user_id: params[:lending][:user_id], item_id: params[:lending][:item_id], dead_line:params[:lending][:dead_line], is_lent:true)
   if @lending.save
      flash[:notice]="アイテムが作成されました"
       redirect_to controller: 'home', action: 'index'
   else
     messages = ""
     @lending.errors.full_messages.each{|msg| messages += "#{msg}¥n"}

     flash[:alert]= messages
      redirect_to  controller: 'home', action: 'index'
   end

 end


end
