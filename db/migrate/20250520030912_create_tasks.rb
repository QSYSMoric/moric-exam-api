class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|

      t.datetime :time, comment: '安排时间'

      t.text :remark, comment: '备注'

      t.string :stage, comment: '阶段'

      t.integer :state, comment: '状态', default: 0

      t.references :company, foreign_key: true, comment: '所属公司'

      t.references :contact, foreign_key: true, comment: '联系人'

      t.references :user, foreign_key: true, comment: '跟进人'

      t.timestamps

    end
  end
end
