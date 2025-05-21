class User < ApplicationRecord

  include Devise::JWT::RevocationStrategies::Allowlist

  devise :database_authenticatable, :registerable,
      :recoverable, :rememberable, :validatable,
      :jwt_authenticatable, jwt_revocation_strategy: self


  has_secure_password

  ## 跟进的公司列表
  has_many :compass
  
  ## 负责的跟进任务
  has_many :followed_companies, class_name: "Company", foreign_key: "follow_person_id"

  ####### 
  # @description: 生成 JWT Token
  # @param
  # @return
  # 
  def generate_jwt

    payload = { user_id: id, exp: 1.day.from_now.to_i }

    JWT.encode(payload, Rails.application.credentials.devise_jwt_secret_key)
    
  end

  ####### 
  # @description: 验证token
  # @return {*}
  # 
  def generate_jwt 

    payload = { user_id: id, exp: 1.day.from_now.to_i }
    
    JWT.encode(payload, Rails.application.credentials.devise_jwt_secret_key)

  end

end