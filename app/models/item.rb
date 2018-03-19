class Item < ApplicationRecord
  has_many :lendings

  scope :search_with_id, -> (id) { where(id: id).first} 

  # 今現在借りている(is_lent: trueである)lendingを返す
  def current_lending
    lendings.order(:updated_at).select { |lending| lending.is_lent == true }.first
  end
end
