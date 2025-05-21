module UserService

  def self.account_recognition( name , password)
  
      u = User.find_by(name: name)

      token = u.generate_jwt
  
  end

  def self.get_users_list

    us = User.all.select(:id,:name)

    puts us

    us

  end

end