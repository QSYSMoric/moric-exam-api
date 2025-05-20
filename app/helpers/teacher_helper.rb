module TeacherHelper

  def full_name(user_id)
    Teacher.find(user_id).name
  end

  def show_name(user_id)
    Teacher.find(user_id).show_name
  end

  def find(user_id = nil)
    Teacher.find(user_id)
  end
    
  def get_info(user_id)
    Teacher.find(user_id)
  end

end