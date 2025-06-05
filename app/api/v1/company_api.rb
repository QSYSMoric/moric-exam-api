module V1

  class CompanyAPI < V1::ApplicationAPI

    format :json

    helpers AuthenticationHelper

    helpers ResponseHelper

    rescue_from Grape::Exceptions::ValidationErrors do |e|

      error!({ code: 400, message: e.message }, 400)
      
    end

    rescue_from ActiveRecord::RecordNotFound do |e|

      error_response("", 500)

    end

    namespace :company do

      helpers do

        ## 公司提交表单  
        params :compony_form do
          requires :name, type:String, desc: '公司名称'
          optional :phone, type:String, desc:'公司电话', regexp: /\A1[3-9]\d{9}\z/
          optional :address, type:String, desc:'公司地址'
          optional :post_code, type:String, desc:'邮编'
          optional :follow_person_id, type:Integer, desc:'跟进人', default: 1
        end

        ## 联系人提交表单       
        params :contact_form do 
          requires :name, type:String, desc: '联系人名称'
          requires :phones, type:Array, desc: '联系人手机', values: { value: ->(v) { v.size > 0 }, message: '至少需要一个手机号' }
          optional :gender, type: String, desc: '联系人性别', values: ["男","女"]
          optional :email, type:String, desc:'联系人邮箱'
          optional :remark, type:String, desc:'备注'
          optional :department, type:String, desc: '部门'
          optional :telephone, type:String, desc:'电话'
          optional :post_code, type:String, desc:'邮编'
          optional :importance, type:String, desc:'重要性', values: ["重要","普通"]
        end

        ## 跟进提交脚本 
        params :task_form do 
          requires :time, type:String, desc: '安排时间'
          requires :stage, type:String, desc: '阶段'
          requires :user_id, type:Integer, desc: '跟进人id'
          optional :state, type:Integer, desc: '跟进状态', default: 0
          requires :contact_id, type:Integer, desc: '联系人id'
          optional :remark, type:String, desc: '备注'
          requires :contact_information, type:String, desc:"联系方式", values: ["电话","邮件","会面","其他"]
        end

      end

      desc "获取公司列表"
      params do
        optional :per_page, type: Integer, desc: '当前页码', default: 1
        optional :limit, type: Integer, desc: '每页数量', default: 10
        optional :company_name, type: String, desc: '查询公司参数'
        optional :follow_person_id, type: Integer, desc: '跟进人id', default: 10
      end
      get do

        a = params[:per_page].to_is

        res = CompanyService.list_query(params[:per_page], params[:limit])
        
        success_response(res)
        
      end

      desc "创建公司"
      params do
        use :compony_form
      end
      post do
        begin

            res = CompanyService.create_compony(params)

            success_response(res)

        rescue Exception => e 
          
            error_response("公司创建失败",500)

        end
      end

      route_param :company_id, type: Integer, desc: 'User ID' do
        desc "修改公司信息"
        params do
          use :compony_form
        end
        put do 
          begin 

            res = CompanyService.set_compony(params[:company_id],params)

            success_response(res)

          rescue Exception => e 
          
            error_response("修改公司失败",500)

          end
        end

        desc "获取公司详情"
        get do
          begin

            res = CompanyService.get_compony(params[:company_id])

            success_response(res)

          rescue Exception => e 
          
            p e

            error_response("公司不存在",500)

          end
        end

        desc "删除公司"
        delete do 
          begin

            res = CompanyService.delete_compony(params[:company_id])

            success_response(res)

          rescue Exception => e 
          
            error_response("删除公司失败",500)

          end
        end

        desc "添加公司的联系人"
        params do
          use :contact_form
        end
        post :add_contact do
          begin
            
            res = CompanyService.add_compony_contact(params[:company_id], params)

            success_response(res)

          rescue Exception => e 
          
            error_response("添加联系人失败",500)

          end
        end

        desc "删除联系人信息"
        params do
          requires :contact_id, type: Integer, desc:'公司的联系人id'
        end
        delete :contact do
          begin
            
            res = CompanyService.delete_compony_contact(params[:contact_id])

            success_response("删除成功")

          rescue Exception => e 
          
            error_response("删除联系人失败",500)

          end
        end

        desc "编辑联系人信息"
        params do
          requires :contact_id, type: Integer, desc:'公司的联系人id'
          use :contact_form 
        end
        put :contact do
          begin
            
            res = CompanyService.add_compony_contact(params[:company_id], params)

            success_response(res)

          rescue Exception => e 
          
            error_response("设置联系人失败",500)

          end
        end

        desc "添加公司的跟进记录"
        params do
          use :task_form
        end
        post :add_task do
          begin
            
            res = CompanyService.add_task(params[:company_id], params)

            success_response(res)

          rescue Exception => e 
          
            error_response("添加跟进记录失败",500)

          end
        end

        desc "编辑公司的跟进记录"
        params do
          requires :task_id,type: Integer, desc: "任务id"
          use :task_form
        end
        put :set_task do
          begin
            
            res = CompanyService.set_task(params[:task_id], params)

            p res

            success_response(res)

          rescue Exception => e 

            error_response("公司不存在",500)

          end

        end

        desc "删除跟进记录"
        params do 
          requires :task_id,type: Integer, desc: "任务id"
        end
        delete :delete_task do
          begin

            p params[:task_id]

            res = CompanyService.delete_task(params[:task_id])

            success_response("删除成功")

          rescue Exception => e 

            error_response("删除失败",500)

          end
        end

        desc "批量更改跟进记录状态"
        params do 
          requires :task_ids,type: Array, desc: "任务id"
        end
        put :set_task_stats do
          begin

            res = CompanyService.set_task_stats(params[:task_ids])

            success_response("更改成功")

          rescue Exception => e 

            error_response("更改失败",500)

          end
        end

      end
    end

  end

end