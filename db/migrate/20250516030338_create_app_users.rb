class CreateAppUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :app_users do |t|

      t.string :name, comment: '姓名'
      t.string :mobile, comment: '手机号'
      t.integer :sex, comment: '性别'
      t.integer :app_user_type, comment: '账号类型'
      t.datetime :login_at, comment: '登录时间'
      t.integer :sub_firm_id, comment: '所属公司'
      t.text :notes, comment: '备注'

      t.timestamps

    end

    add_index :app_users, :mobile, unique: true
    add_index :app_users, :app_user_type
    add_index :app_users, :sub_firm_id

  end
end
