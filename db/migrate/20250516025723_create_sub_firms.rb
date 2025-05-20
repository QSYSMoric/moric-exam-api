class CreateSubFirms < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_firms do |t|

      t.string :firm_name, comment: '公司名称'
      t.float :registered_capital, scale: 2, comment: '注册资本'
      t.string :address, comment: '公司地址'
      t.boolean :active , default: true, comment: '是否激活'
      t.integer :firm_property, comment: '公司性质'

      t.timestamps

    end

    add_index :sub_firms, :active

  end
end
