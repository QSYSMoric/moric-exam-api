class Company < ApplicationRecord

  ## 公司下面的联系人
  has_many :contacts, dependent: :destroy

  ## 公司下的跟进任务
  has_many :tasks, dependent: :destroy

  ## 公司下的跟进人
  belongs_to :follow_person, class_name: 'User', optional: true
  
end