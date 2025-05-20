class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
      create_table :companies do |t|

        t.string :name, comment: '公司名'

        t.string :phone, comment: '公司联系电话'

        t.string :address, comment: '公司地址'

        t.string :post_code, comment: '邮编'

        t.references :follow_person, foreign_key: { to_table: :users }, comment: '跟进人'

        t.timestamps

      end

      add_index :companies, :name

  end
end
