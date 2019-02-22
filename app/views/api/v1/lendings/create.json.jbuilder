# json.array! @lendings, :user_id, :item_id, :dead_line, :is_lent, :created_at, :updated_at


# companies.json にアクセスすると、このjbuilderが呼ばれる

# json.キー名 do ~ end を使うと、
# 入れ子構造を作ることができる
json.lendings do
  # json.array!(配列) do |要素名| end を使うと、
  # 配列構造を作ることができる
  json.array!(@lendings) do |lending|
    # json.partial! モデル変数 を使うと、
    # 部分テンプレートを表示する
    json.partial!(lending)
  end
end
