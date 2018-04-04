require 'csv'

csv_data = CSV.read("#{Rails.root}/public/csv/goodsInfo.csv", headers: true)
p "#{Rails.root}/public/csv/goodsInfo.csv"
puts "start..."

csv_data.each do |data|
  p item = Item.create(
    name: data["item_name"],
    serial_number: data["serial_number"],
    kind: data["kind"])
end

puts "complete!"
