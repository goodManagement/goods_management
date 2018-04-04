module ItemsHelper
  DEAD_LINE = 4

  def onloan_title
    filter = params[:filter].to_i
    html = ""
    if filter == DEAD_LINE
      html = "<h1 style='color:red'>貸出期限切れ一覧</h1>"
    else
      html = "<h1>貸出中一覧</h1>"
    end
    html.html_safe
  end


end
