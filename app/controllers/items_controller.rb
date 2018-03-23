class ItemsController < ApplicationController
  def index
    @items = []
    30.times do |i|
      item = Item.new(serial_number:0000+i, name:"item#{i}", kind:i)
      @items.push(item)
    end
    render :index, layout: "application_with_navbar"
  end

  def new
    @item = Item.new
    render :new, layout: "application_with_navbar"
  end

  def create
    @item = Item.new(item_params)
   if @item.save
      flash[:notice]="アイテムが作成されました"
       redirect_to("/items/new")
   else
     messages = ""
     @item.errors.full_messages.each{|msg| messages += "#{msg}¥n"}

     flash[:alert]= messages
      redirect_to("/items/new")
   end

  end

  def item_params
    params.require(:item).permit(:name, :serial_number,:kind)
  end

  def destroy
    items_serial_numbers = params[:delete][:serial_numbers].split(",")
    items_serial_numbers.each do | item_serial_number |
      @item = Item.find_by(serial_number: item_serial_number)
      if @item.present?
        begin
          @item.destroy
        rescue
        messages = ""
          @item.errors.full_messages.each{|msg| messages += "#{msg}¥n"}
          flash[:alert]= messages
          redirect_to("/items/delete") and return
        end
      else # @item = nilだったら
        set_flash(:alert,"#{item_serial_number}のアイテムは存在しません")
        redirect_to("/items/delete") and return
      end
    end
    set_flash(:notice,"アイテムが削除されました")
    redirect_to("/items/delete") and return
  end

  def delete
      render :delete, layout: "application_with_navbar"
  end

  def onloan
      render :onloan, layout: "application_with_navbar"
  end

end
