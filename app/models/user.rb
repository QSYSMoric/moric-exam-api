class User < ApplicationRecord

  ## 跟进的公司列表
  has_many :compass
  
  ## 负责的跟进任务
  has_many :followed_companies, class_name: "Company", foreign_key: "follow_person_id"

  ####### 
  # @description: 生成 JWT Token
  # @param
  # @return
  # 
  def generate_jwt(user)

      exp = 24.hours.from_now.to_i

      payload = {
        sub: user.id,
        exp: exp
      }

      JWT.encode(payload,Rails.application.credentials.devise_jwt_secret_key!)
  end

  ####### 
  # @description: 验证token
  # @return {*}
  # 
  def generate_jwt 

    decoded = JWT.decode(token,Rails.application.credentials.devise_jwt_secret_key!,true)

  end

end