module V1

  class UserAPI < V1::ApplicationAPI

    format :json

    helpers AuthenticationHelper

    helpers ResponseHelper

    rescue_from Grape::Exceptions::ValidationErrors do 
      error!({ code: 400, message: '参数错误' }, 400)
    end

    namespace :users do

      before do
        Rails.logger.info "请求开始"
      end

      after do
        Rails.logger.info "请求结束，返回内容: #{body}"
      end

      helpers do 

        params :user_id do
          requires :user_id, type: Integer, desc: 'User ID'
        end

        params :user_form do
          requires :name, type: String, desc: '用户名称'
          requires :role, type: Integer, desc: '账号角色', values: [0,1]
          requires :gender, type: String, desc: '用户性别', values: ["男","女"]
          requires :password_digest, type: String, desc:"密码"
          optional :notes, type: String, desc: '备注'
        end

      end

      desc "获取用户自身信息"
      get do 

        authenticate_user!

        success_response(current_user)
        
      end

      desc "获取用户列表"
      get :list do 

        res = UserService.get_users_list

        success_response(res)
        
      end

    end
    
  end
  
end