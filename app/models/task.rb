class Task < ApplicationRecord

  ## 跟进记录所属公司
  belongs_to :company

  ## 跟进记录的公司联系人
  belongs_to :contact

  ## 跟进记录的负责人
  belongs_to :follow_person, class_name: 'User'

end