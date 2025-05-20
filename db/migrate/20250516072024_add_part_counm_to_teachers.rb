class AddPartCounmToTeachers < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :is_free, :boolean
  end
end
