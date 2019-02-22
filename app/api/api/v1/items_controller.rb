class Api::V1::ItemsController < ApplicationController
  before_action :authenticate_user!

  IS_NOT_LENT = 2
  IS_LENT = 3
  DEAD_LINE = 4

   def index
     @item = Item.all
   end

  def search
    # @items = Item.all
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

  end

end
