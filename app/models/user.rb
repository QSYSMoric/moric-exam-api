class User < ApplicationRecord

  ## 跟进的公司列表
  has_many :compass
  
  ## 负责的跟进任务
  has_many :followed_companies, class_name: "Company", foreign_key: "follow_person_id"

end