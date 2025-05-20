module V1

  class SessionAPI < V1::ApplicationAPI

    format :json

    helpers AuthenticationHelper

    helpers ResponseHelper

    namespace :session do

      desc "登录"
      params do 
        requires :name, type: String, desc: "账号"
        requires :mobile, type: String, desc:"手机号"
      end
      post :sign do 

        p ::UserService::Text1

        token = UserService.account_recognition(params[:name],params[:mobile])

        success_response(token)

      end
      
    end

  end 
  
end