class AddFollowPersonToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_reference :companies, :follow_person, foreign_key: { to_table: :users }, comment: '跟进人'
  end
end
