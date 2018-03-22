module ApplicationHelper
  # flashを表示する
  def show_flash
    messages = ""
    flash.each do |message_type, message|
      if message_type == "notice"
        message.split("¥n").each{ |msg| messages += "<div class='alert alert-success' style='margin-bottom:0px'>#{msg}</div>" }
      elsif message_type == "alert"
        message.split("¥n").each { |msg| messages += "<div class='alert alert-danger' style='margin-bottom:0px'>#{msg}</div>" }
      else
        message.split("¥n").each{ |msg| messages += "<div class='alert alert-#{message_type}' style='margin-bottom:0px'>#{msg}</div>" }
      end
    end
    return messages.html_safe
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
          <li><a class="dropdown-item" href="items/new">物品追加</a></li>
          <li><a class="dropdown-item" href="items/delete">物品削除</a></li>
        </ul>
      </li>
      EOF
      html.html_safe
    end
  end
end
