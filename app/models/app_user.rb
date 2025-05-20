class AppUser < ApplicationRecord

  include Devise::JWT::RevocationStrategies::Denylist

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  def show_name
    return '' if name.blank?
    if name.include?('老师')
      name
    else
      "#{name[0]}老师"
    end
  end

  def generate_jwt
    payload = { user_id: id, exp: 1.day.from_now.to_i }
    JWT.encode(payload, Rails.application.credentials.devise_jwt_secret_key)
  end

  def decode_jwt(token)
    JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key)
  end

  def self.like(keyword)
    where("name LIKE ?", "%#{keyword}%")
  end

end
