# == Schema Information
# Author: moric 183957330@qq.com
# Date: 2025-05-15 16:23:15
# LastEditors: moric 183957330@qq.com
# LastEditTime: 2025-05-20 17:36:30
# FilePath: /moric-exam-api 后端 /app/api/v1/base.rb
# Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
# 
module V1 
  class Base < Grape::API

    mount V1::UserAPI 
  
    mount V1::SessionAPI

    mount V1::CompanyAPI

  end
end