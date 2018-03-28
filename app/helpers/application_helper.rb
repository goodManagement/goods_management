module ApplicationHelper

  # flashをsetしていく
  def set_flash(message_type, message)
    flash[message_type] = message
  end

  # flashを表示する
  def show_flash
    html = ""
    flash.each do |message_type, messages|
      if message_type == "notice"
        messages.split("¥n").each { |msg| html += "<div class='alert alert-success' style='margin-bottom:0px'>#{msg}</div>" }
      elsif message_type == "alert"
        messages.split("¥n").each { |msg| html += "<div class='alert alert-danger' style='margin-bottom:0px'>#{msg}</div>" }
      else
        messages.split("¥n").each { |msg| html += "<div class='alert alert-#{message_type}' style='margin-bottom:0px'>#{msg}</div>" }
      end
    end
    return html.html_safe
  end

  # adminユーザーのみのメニューを表示する
  def show_admin_menu
    if current_user.is_admin
      html =  <<-EOF
      <li class="nav-item dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
          setting
          <span class="caret"></span>
        </a>
        <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <li><a class="dropdown-item" href="/items/new">物品追加</a></li>
          <li><a class="dropdown-item" href="/items/delete">物品削除</a></li>
        </ul>
      </li>
      EOF
      html.html_safe
    end
  end
end
