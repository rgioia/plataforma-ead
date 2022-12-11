class Course < ApplicationRecord
  belongs_to :category

  validates :name, presence: true
  validates :start_date, presence: true
  validates :price, presence: true
  validates :limit_subscriptions, presence: true

  has_one_attached :photo

  delegate :name, to: :category, prefix: :category
end