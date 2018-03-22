module HomeHelper

  #貸出期限を超えていたらhurryクラスを付与する
  def add_hurry_class(lending)
    if lending.dead_line <= Time.current
      "hurry"
    else
      ""
    end
  end
end
