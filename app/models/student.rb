class Student < ApplicationRecord

  scope :age_then_18, -> { where('age > ?', 18) }

  belongs_to :teacher

  validate :age_then_age

  private

    def age_then_age

      if age.blank?
        errors.add(:age, "年龄不能为空")
        false
      end

      if age < 0
        errors.add(:age, "年龄必须大于0岁")
        return false
      else 
        true
      end

    end

end
