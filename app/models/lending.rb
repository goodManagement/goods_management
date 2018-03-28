class Lending < ApplicationRecord
  validates :dead_line, presence: true
  belongs_to :user
  belongs_to :item

  scope :search_with_id, -> (id) { where(id: id).first }


 # 以前に延長されたかどうか判断
  def is_renewed?
     created_at < updated_at
  end

  # itemを返却する
  def return_item
    !Lending.update(id, is_lent: false).is_lent
  end

  # 今現在貸出期限を超えているitemを全取得する
  def self.dead_items(page)
    Item.to_kaminari_object(page,
      Lending.where(is_lent: true).select{ |lending| lending.dead_line < Date.today }.map{ |lending| lending.item })
  end

end
