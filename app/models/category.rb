class Category < ApplicationRecord
  has_many :courses, dependent: :restrict_with_error

  validates :name, presence: true
  validates :name, uniqueness: true

  def self.order_by_name
    order(name: :asc)
  end
end
