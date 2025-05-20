class AddPartStringToTeachers < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :age, :integer, comment: "年龄"
    add_column :teachers, :descriotion, :string, comment: "所教课程"
  end
end
