class ItemsController < ApplicationController
  def index
    @items = []
    30.times do |i|
      item = Item.new(serial_number:0000+i, name:"item#{i}", kind:i)
      @items.push(item)
    end
    render :index, layout: "application_with_navbar"
  end
end
