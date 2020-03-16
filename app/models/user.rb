class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
 
  # relationships
  has_many :stories
  has_many :follows
  has_many :bookmarks
  has_one_attached :avatar
  
  # validations
  validates :username, presence: true, uniqueness: true

  # 設定user的方法: follow
  def follow?(user)
    follows.exists?(following: user)
  end

  def follow!(user)
    if follow?(user)
      follows.find_by(following: user).destroy
      return 'Follow'
    else
      follows.create(following: user)
      return 'Following'
    end
  end
  
  # 設定user的方法: bookmark
  def bookmark?(story)
    bookmarks.exists?(story: story)
  end

  def bookmark!(story)
    if bookmark?(story)
      bookmarks.find_by(story: story).destroy
      return "Unbookmarked"
    else
      bookmarks.create(story: story)
      return "Bookmarked"
    end
  end

end
