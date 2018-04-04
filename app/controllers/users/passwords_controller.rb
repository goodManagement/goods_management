# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  :require_no_authentication, except: [:edit, :update]
  before_action :authenticate_user! except: [:edit, :update]

  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   @user = User.new
  # end
  #
  #
  # def update
  #   current_password = params[:user][:current_password]
  #   updating_user = AuthenticatedUser.new(update_user_params) # 比較用のユーザー
  #   @user = User.find_by(owner: updating_user[:owner], vendor: updating_user[:vendor])
  #   # ユーザーが存在しかつユーザーのパスワードが正しければ
  #   if @user && @user.authenticate(current_password)
  #     update_password_digest = updating_user.password
  #     if @user.update_attributes(authenticated_user_params)
  #       flash[:success] = "your password was updated!!"
  #       render 'new'
  #     end
  #   else
  #     flash[:danger] = "your password was incorrect."
  #     render 'edit'
  #   end
  #     flash[:danger] = "your password was not able to update."
  #     render 'edit'
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
