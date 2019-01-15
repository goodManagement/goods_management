json.user_data do
  json.user @user, :email, :encrypted_password, :is_admin, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :created_at, :updated_at, :username, :username
  json.comments do
    json.array! @user.comments, :park_id, :body, :like_count
  end
end
