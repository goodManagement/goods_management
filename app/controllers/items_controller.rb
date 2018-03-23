class ItemsController < ApplicationController
  def index
    filter = params[:filter].to_i

    @items = Item.page(params[:page]).per(10)
    if filter == IS_NOT_LENT
      @items = Item.not_lent_items(params[:page])
    elsif filter == IS_LENT
      @items = Item.lent_items(params[:page])
    elsif filter == DEAD_LINE
      @items = Lending.dead_items(params[:page])
    end
    render :index, layout: "application_with_navbar"
  end

  def new
    @item = Item.new
    render :new, layout: "application_with_navbar"
  end


  # items/search　itemの検索を行う
  def search
    search_name = params[:search][:name]
    search_kind = params[:search][:kind]

    @items = Item.page(params[:page]).per(10)
    if search_kind.present? and search_kind.to_i > 0
      @items = @items.where(kind: search_kind)
    elsif search_name.present?
      @items = @items.where("name like '%#{search_name}%'")
    end
    render :index, layout: "application_with_navbar"
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
<<<<<<< HEAD
        messages = ""
          @item.errors.full_messages.each{|msg| messages += "#{msg}¥n"}
=======
          messages = ""
          @item.errors.full_messages.each {|msg| messages += "#{msg}¥n"}
>>>>>>> e5fb28bd7e03d40c370c7d752152a9f0b8314ba3
          flash[:alert]= messages
          redirect_to("/items/delete") and return
        end
      else # @item = nilだったら
<<<<<<< HEAD
        set_flash(:alert,"#{item_serial_number}のアイテムは存在しません")
=======
        flash[:alert] = "#シリアルナンバーが{item_serial_number}のアイテムは存在しません"
>>>>>>> e5fb28bd7e03d40c370c7d752152a9f0b8314ba3
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
