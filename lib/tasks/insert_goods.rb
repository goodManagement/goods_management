require 'csv'

csv_data = CSV.read("#{Rails.root}/public/csv/goodsInfo.csv", headers: true)
p "#{Rails.root}/public/csv/goodsInfo.csv"
puts "start..."

csv_data.each do |data|
  # intro_msg = "#{data["item_name"]}, #{data["serial_number"]}, #{data["kind"]}\n"
  p item = Item.create(
    name: data["item_name"],
    serial_number: data["serial_number"],
    kind: data["kind"])

  # p item
end

puts "complete!"
