module V1 
  class TeacherAPI < Grape::API
  
    format :json

    rescue_from Grape::Exceptions::ValidationErrors do 
      error!({ code: 400, message: '参数错误' }, 400)
    end

    namespace :teachers do

      helpers TeacherHelper

      before do
        Rails.logger.info "请求开始"
        @current_teacher = Teacher.first
        p @current_teacher
      end

      after do
        Rails.logger.info "请求结束，返回内容: #{body}"
      end

      desc "获取教师信息"
      params do
        requires :teacher_id, type: Integer, desc: 'Teacher ID'
      end
      get :info do
        begin 
          find(params[:teacher_id])
        rescue => e
          error!({ code: 404, message: e.message }, 404)
        end
      end

      desc "查询年龄大于18的学生和学生的老师的信息"
      get :then18s do
        students = Student.where('age > ?', 18)
        teachers = Teacher.where('age > ?', 18)

        {
          students: students,
          teachers: teachers
        }
      end

    end
  end
end