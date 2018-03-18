class Item < ApplicationRecord
  has_many :lendings

  # 今現在借りている(is_lent: trueである)lendingを返す
  def current_lending
    lendings.order(:updated_at).select { |lending| lending.is_lent == true }
  end
end
