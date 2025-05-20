class TeacherStructure < ApplicationRecord
  belongs_to :teacher, class_name: 'Teacher', foreign_key: :teacher_id
  belongs_to :super, class_name: 'Teacher', foreign_key: :super_id
end
