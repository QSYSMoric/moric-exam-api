module UserService

  def self.account_recognition(name,password)

      p name,password
  
      u = User.find_by(name: name, password_digest: password)

      p u

      unless u

        return error_response("用户名或密码错误", 401)

      end

      unless u.password_digest == password

        return error_response("用户名或密码错误", 401)

      end

      token = u.generate_jwt();
  
  end
end