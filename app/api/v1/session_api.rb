module V1

  class SessionAPI < V1::ApplicationAPI

    format :json

    helpers AuthenticationHelper

    helpers ResponseHelper

    namespace :session do

      desc "登录"
      params do 
        requires :name, type: String, desc: "账号"
        requires :password, type: String, desc:"密码"
      end
      post :sign do 

        token = UserService.account_recognition(params[:name],params[:password])

        success_response(token)

      end
      
    end

  end 
  
end