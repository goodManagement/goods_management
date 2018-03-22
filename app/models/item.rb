class Item < ApplicationRecord
  validates :name, presence: true
  validates :serial_number, presence: true, uniqueness: true
  has_many :lendings

  scope :search_with_id, -> (id) { where(id: id).first }

  # 今現在借りている(is_lent: trueである)lendingを返す
  def current_lending
    lendings.order(:updated_at).select { |lending| lending.is_lent == true }.first
  end

  # 今現在貸し出されているitemを全取得する
  def self.lent_items
    Item.all.select {|item| item.current_lending.present? }
  end

  # 今現在貸し出されていないitemを全取得する
  def self.not_lent_items
    Item.all.select {|item| item.current_lending.blank? }
  end





end
