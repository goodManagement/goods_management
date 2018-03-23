class Item < ApplicationRecord
  validates :name, presence: true
  validates :serial_number, presence: true, uniqueness: true
  has_many :lendings

  scope :search_with_id, -> (id) { where(id: id).first }

  scope :search_with_kind, -> (kind) { where(kind: kind) }

  # 今現在借りている(is_lent: trueである)lendingを返す
  def current_lending
    lendings.order(:updated_at).select { |lending| lending.is_lent == true }.first
  end

  # 今現在貸し出されているitemを全取得する
  def self.lent_items(page)
    Item.to_kaminari_object(page, Item.all.select {|item| item.current_lending.present? })
  end

  # 今現在貸し出されていないitemを全取得する
  def self.not_lent_items(page)
    Item.to_kaminari_object(page, Item.all.select {|item| item.current_lending.blank? })
  end

  private
  # kaminariオブジェクトにする
  def self.to_kaminari_object(page, array)
    Item.page(page).per(10).where(id: array.map {|element| element.id } )
  end

end
