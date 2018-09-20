class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, only: [:new, :create, :destroy, :delete]


  IS_NOT_LENT = 2
  IS_LENT = 3
  DEAD_LINE = 4

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

    search_kind = params[:kind].to_i || 0
    search_name = params[:name] || ""

    if search_kind.present? and search_kind.to_i > 0
      @items = @items.where(kind: search_kind)
    elsif search_name.present?
      @items = @items.where("name like '%#{search_name}%'")
    end

    render :index, layout: "application_with_navbar"
  end

  # items/create に対応
  def new
    @item = Item.new
    render :new, layout: "application_with_navbar"
  end

  def create
    @item = Item.new(item_params)

    # レコード数+1の数を下４桁に、kindの数を上1桁に設定し、5桁のserial_numberを生成
    # @item.serial_number = (@item.kind * 10000) + Item.where(kind: @item.kind).count + 1

    # 入力したkindが初めて入力されたものかを調べる
    if Item.where(kind: @item.kind).maximum(:serial_number) == nil
      # nilの場合、1をserial_numberに設定
      @item.serial_number = (@item.kind * 10000) + Item.where(kind: @item.kind).count + 1;
    else
      # 指定したkindに該当するserial_numberの最大値に1を加えた数をserial_numberに設定
      @item.serial_number = Item.where(kind: @item.kind).maximum(:serial_number) + 1
    end


    if @item.save
      set_flash(:notice, "アイテムが作成されました")
      redirect_to("/items/new")
    else
      messages = ""
      @item.errors.full_messages.each{|msg| messages += "#{msg}¥n"}
      set_flash(:alert, messages)

      redirect_to("/items/new")
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
          @item.errors.full_messages.each {|msg| messages += "#{msg}¥n"}
          set_flash(:alert, messages)
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
    @items = Item.lent_items(params[:page])
    filter = params[:filter].to_i

    if filter == DEAD_LINE
      @items = Lending.dead_items(params[:page])
      p @items
    end
    render :onloan, layout: "application_with_navbar"
  end

  private
  def item_params
    params.require(:item).permit(:name, :serial_number,:kind)
  end

end
