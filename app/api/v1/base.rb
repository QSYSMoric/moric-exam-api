module V1 
  class Base < Grape::API

    mount V1::UserAPI 
    
    mount V1::TeacherAPI

    mount V1::SessionAPI

  end
end