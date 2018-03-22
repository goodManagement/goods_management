class ItemsController < ApplicationController
  ALL = 1
  IS_NOT_LENT = 2
  IS_LENT = 3
  DEAD_LINE = 4

  def index
    @items = Item.all
    filter = params[:filter]
    if filter == IS_LENT
      @items = @items.where(is_lent: true)
    elsif filter == DEAD_LINE
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
      flash[:notice] = "アイテムが作成されました"
      redirect_to("/items/new")
    else
      messages = ""
      @item.errors.full_messages.each{|msg| messages += "#{msg}¥n"}


      @items = Item.all
      if search_kind.present? and search_kind.to_i > 0
        @items = @items.where(kind: search_kind)
        p @items
      elsif search_name.present?
        @items = @items.where("name like '%#{search_name}%'")
      end
    end
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
        flash[:alert] = "#{item_serial_number}のアイテムは存在しません"
        redirect_to("/items/delete") and return
      end
    end
    flash[:notice]="アイテムが削除されました"
    redirect_to("/items/delete") and return
  end

  def delete
    render :delete, layout: "application_with_navbar"
  end


  def item_params
    params.require(:item).permit(:name, :serial_number,:kind)
  end

end
