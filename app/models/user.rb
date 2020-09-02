class User < ApplicationRecord

  validates :name, {presence:true, uniqueness:true}
  #validates :password, {length: {minimum: 6}}
  validates :password, presence: true,length: { minimum: 6 },on: :create
  validates :self_intro, length: {maximum: 20}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence:true, uniqueness:true, format: {with:VALID_EMAIL_REGEX}}
  has_secure_password validations: false
  
  def post
    return Post.find_by(user_id: self.id)
  end
  
end
