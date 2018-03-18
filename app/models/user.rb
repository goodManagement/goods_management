class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
  authentication_keys: [:username]
  # 認証で使うキーを指定
  # devise :database_authenticatable, :trackable, :validatable,
  #   authentication_keys: [:username]

  has_many :lendings

  # 今現在借りている(is_lent: trueである)lendingを返す
  def current_lending
    lendings.order(:updated_at).select { |lending| lending.is_lent == true }.first
  end

  # ユーザー名で検索
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if username = conditions.delete(:username)
      where(conditions).where(username: username).first
    else
      where(conditions).first
    end
  end

  # 登録時に email を不要にする
  def email_required?
    false
  end
  def email_changed?
    false
  end
end
