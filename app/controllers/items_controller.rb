class ItemsController < ApplicationController
  def index
    @items = Item.all
    render :index, layout: "application_with_navbar"
  end

  def new
    render :new, layout: "application_with_navbar"
  end

  def search
    search_name = params[:search][:name]
    search_kind = params[:search][:kind]

    p "アイエうお"

    p search_kind

    @items = Item.all
    if search_kind.present? and search_kind.to_i > 0
      @items = @items.where(kind: search_kind)
      p @items
    elsif search_name.present?
      @items = @items.where("name like '%#{search_name}%'")
    end
    render :index, layout: "application_with_navbar"
  end
end
