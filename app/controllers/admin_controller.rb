class AdminController < ApplicationController
  before_action :require_admin

  def edit
    @users = User.not_admin_users
  end

  def update
    requested_users = admin_users
    p requested_users

    requested_users.each do |user|
      unless user.update(is_admin: true) # ユーザーを管理者にすることに失敗したら
        set_flash(:danger, "#{user.name}の管理者ユーザーへのアップデートに失敗しました")
        redirect_to("/admin/edit") and return
      end
    end
    set_flash(:success, "管理者ユーザーのアップデートが完了しました")
    redirect_to("/home/index") and return
  end

  private
  def admin_users
    admin_users_id = params.require(:admin).select{|key, value| value=="1" }
    requested_users = []
    admin_users_id.each {|key, v| requested_users.push(User.search_with_id(key.to_i)) }

    return requested_users
  end


end
