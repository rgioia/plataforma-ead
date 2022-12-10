class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  validates :email, uniqueness: true
  validates :email, presence: true
end
