module DeviseHelper

  # deviseのエラーメッセージを表示する
  def devise_error_messages!
    return "" if resource.errors.empty? and flash.empty?

    html = ""
    # エラーメッセージ用のHTMLを生成
    messages = resource.errors.full_messages
    if flash.present?
      flash.each { |type, msg|  messages.push(msg) }
    end

    messages.each do |msg|
      html += <<-EOF
      <div class="error_field" role="alert">
      <p class="error_msg">・#{msg}</p>
      </div>
      EOF
    end
    html.html_safe
  end
  
end
