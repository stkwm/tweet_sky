class Post < ApplicationRecord
    
  validates :content, {presence:true, length: {maximum:200}}
  
  
  def user
    return User.find_by(id: self.user_id)
  end
    
end
