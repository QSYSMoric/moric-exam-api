class AddContactToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :contact_information, :string
  end
end
