class CreateTeacherStructures < ActiveRecord::Migration[5.2]
  def change
    create_table :teacher_structures do |t|

      t.integer :teacher_id
      
      t.integer :super_id

      t.timestamps
    end
  end
end
