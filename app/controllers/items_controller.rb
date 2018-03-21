class ItemsController < ApplicationController
  def index
    @items = []
    30.times do |i|
      item = Item.new(serial_number:0000+i, name:"item#{i}", kind:i)
      @items.push(item)
    end
    p "Items#index"
    # p @items
    render :index, layout: "application_with_navbar"
  end

  def new
    render :new, layout: "application_with_navbar"
  end

  def search
    search_name = params[:search][:name]
    search_kind = params[:search][:kind]

    @items = Item.all
    if search_kind.present?
      @items = @items.where(kind: search_kind)
      p @items
    elsif search_name.present?
      @items = @items.where("name like '%#{search_name}%'")
    end
    p "Items#search"

    p @items
    render :index, layout: "application_with_navbar"
  end
end
