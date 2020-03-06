class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :stories
  has_one_attached :avatar
  validates :username, presence: true, uniqueness: true
end
