module UserService

  Text1 = '1233132'

  def self.account_recognition(name,mobile)
  
      u = AppUser.find_by(name: name)

      unless u
        return error_response("手机号或密码错误", 401)
      end

      unless u.mobile == mobile
        return error_response("手机号不存在", 401)
      end

      token = u.generate_jwt();
  
  end
end