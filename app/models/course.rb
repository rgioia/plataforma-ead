class Course < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged
  validates :slug, uniqueness: true

  belongs_to :category
  belongs_to :teacher, optional: true

  has_many :subscriptions, dependent: :restrict_with_error

  validates :name, presence: true
  validates :start_date, presence: true
  validates :price, presence: true
  validates :limit_subscriptions, presence: true

  has_one_attached :photo

  delegate :name, to: :category, prefix: :category

  def can_subscribe?
    limit_subscriptions > subscriptions.without_status(:canceled).count
  end

  private
  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end