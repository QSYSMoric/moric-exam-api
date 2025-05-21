class Contact < ApplicationRecord
  
  ## 联系人所属公司
  belongs_to :company

  def masked_phones
    Array(phones).map do |phone|
      next unless phone.is_a?(String)
      if phone.size >= 7
        phone.gsub(/(\d{3})\d+(\d{4})/, '\1****\2')
      else
        phone
      end
    end.compact
  end

end