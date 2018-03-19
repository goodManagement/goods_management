module ApplicationHelper
  def show_flash
    messages = ""
    flash.each do |message_type, message|
        if message_type == "notice"
          messages += "<div class='alert alert-success'>#{message}</div>"
        elsif message_type == "alert"
          messages += "<div class='alert alert-danger'>#{message}</div>"
        else
          messages += "<div class='alert alert-#{message_type}'>#{message}</div>"
        end
    end
    return messages.html_safe
  end

end
