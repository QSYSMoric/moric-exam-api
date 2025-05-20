module UserHelper

  def full_name(user_id)
     AppUser.find(user_id).name
  end

  def show_name(user_id)
    AppUser.find(user_id).show_name
  end

  def find(user_id = nil)
    AppUser.find(user_id)
  end
    
  def get_info(user_id)
    AppUser.find(user_id)
  end

end