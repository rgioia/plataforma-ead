class Category < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged
  validates :slug, uniqueness: true

  has_many :courses, dependent: :restrict_with_error

  validates :name, presence: true
  validates :name, uniqueness: true

  def self.order_by_name
    order(name: :asc)
  end

  private
  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
