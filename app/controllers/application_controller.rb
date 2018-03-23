class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :flash_clear

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  # end

  protected
  def after_sign_up_path_for(resource)
    #Or :prefix_to_your_route
    home_index_path
  end

  def after_sign_in_path_for(resource)
    # defaultではログイン後にcommunitiesのshowに飛ばす
    home_index_path
  end

  def after_sign_out_path_for(resource)
    new_user_registration_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:subdomain, :username, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:subdomain, :username, :email, :password, :remember_me) }
  end

  def flash_clear
    keys = ["danger", "success"]
    keys.each do |key|
      if flash[key].present?
        flash.delete(key)
      end
    end
  end

  def set_flash(alert_type,text)
    flash[alert_type]="#{text}"
  end

end
