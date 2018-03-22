class LendingsController < ApplicationController
  def create
    @lending = Lending.new(user_id: current_user.id, item_id:params[:serial_number] , dead_line:params[:dead_line], is_lent:true)
   if @lending.save
      flash[:notice]="アイテムが作成されました"
       redirect_to("/")
   else
     messages = ""
     @lending.errors.full_messages.each{|msg| messages += "#{msg}¥n"}

     flash[:alert]= messages
      redirect_to("/")
   end

 end


end
