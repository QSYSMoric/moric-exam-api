class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|

      t.string :name, comment: '姓名'

      t.string :gender, comment: '性别'

      t.string :importance, comment: '重要性'

      t.string :department, comment: '部门'      

      t.string :phones, array: true, default: [], comment: '手机'

      t.string :telephone, comment: '电话'

      t.string :email, comment: '邮箱'

      t.string :remark, comment: '备注'

      t.references :company, foreign_key: true, comment: '所属公司'

      t.timestamps
      
    end
  end
end
