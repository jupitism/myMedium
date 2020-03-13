class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
 
  # relationships
  has_many :stories
  has_many :follows
  has_one_attached :avatar
  
  # validations
  validates :username, presence: true, uniqueness: true

  # 設定user的方法
  def follow?(user)
    follows.exists?(following: user)
  end

  def follow!(user)
    if follow?(user)
      follows.find_by(following: user).destroy
      return 'Follow'
    else
      follows.create(following: user)
      return 'Followed'
    end
  end

end
