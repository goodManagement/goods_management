class Lending < ApplicationRecord
  belongs_to :user
  belongs_to :item

 # 延長できるかどうか判断
  def is_renewed?
     created_at < updated_at
  end

  def return_item
    update(is_lent=false)
  end

  def renew_item
    
  end

end
