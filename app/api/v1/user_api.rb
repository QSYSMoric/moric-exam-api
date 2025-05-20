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
          requires :mobile, type: String, desc: '用户手机号', regexp: /\A1[3-9]\d{9}\z/
          requires :sex, type: Integer, desc: '用户性别', values: [0,1]
          requires :app_user_type, type: Integer, desc: '用户类型', values: [0,1]
          optional :notes, type: String, desc: '备注'
        end

      end

      desc "动态路由获取用户的名称"
      route_param :user_id, type: Integer, desc: 'User ID' do
        desc '获取用户的名字'
        get do
          begin 
            show_name(params[:user_id])
          rescue => e
            error!({ code: 404, message: e.message }, 404)
          end
        end
      end

      desc "获取用户自身信息"
      get do 

        authenticate_user!

        success_response(current_user)
      end

      desc "更新用户信息"
      params do
        use :user_form
      end 
      post :info do 
        begin
          user = find(@current_user.id)
          if user
            user.update!(
              name: params[:name],
              sex: params[:sex],
              app_user_type: params[:app_user_type],
              notes: params[:notes]
            )
            { code: 200, message: '更新成功', data: user }
          else
            error!({ code: 404, message: '用户不存在' }, 404)
          end
        rescue => e
          error!({ code: 404, message: e.message }, 404)
        end
      end

    end
    
  end
  
end