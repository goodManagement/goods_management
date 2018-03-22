class Lending < ApplicationRecord
  validates :dead_line, presence: true
  belongs_to :user
  belongs_to :item

 # 延長できるかどうか判断
  def is_renewed?
     created_at < updated_at
  end

  # itemを返却する
  def return_item
    update(is_lent=false)
  end


end
