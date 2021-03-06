class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # after_action :flash_clear

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  # end

  protected
  def after_sign_up_path_for(resource)
    home_index_path
  end

  def after_sign_in_path_for(resource)
    home_index_path
  end

  def after_sign_out_path_for(resource)
    new_user_registration_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:subdomain, :username, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:subdomain, :username, :email, :password, :remember_me) }
  end

  # flashをクリアーする
  def flash_clear
    keys = ["danger", "success"]
    keys.each do |key|
      if flash[key].present?
        flash.delete(key)
      end
    end
  end

  # flashをsetする
  def set_flash(alert_type,text)
    flash[alert_type]="#{text}"
  end

  protected
  def require_admin
    unless current_user.is_admin
        set_flash(:danger, "あなたは管理者ではありません。このメニューは使えません。")
        redirect_to('/home/index')
    end
  end

end
