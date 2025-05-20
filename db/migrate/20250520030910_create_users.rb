class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|

      t.string :name, comment: '姓名'

      t.string :gender, comment: '性别'

      t.integer :role, comment: '角色'

      t.string :password_digest, comment: '密码'

      t.timestamps
      
    end
  end
end
