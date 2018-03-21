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
end
