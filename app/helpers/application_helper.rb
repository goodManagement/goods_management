module ApplicationHelper
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

end
