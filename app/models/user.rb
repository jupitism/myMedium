class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :stories
  validates :username, presence: true, uniqueness: true
end
