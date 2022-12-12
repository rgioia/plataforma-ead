class Person < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged
  validates :slug, uniqueness: true

  belongs_to :user, dependent: :destroy

  has_one :teacher

  validates :name, :age, presence: true

  accepts_nested_attributes_for :user

  delegate :email, to: :user, prefix: :user

  attr_accessor :created_by_administrator

  def self.not_teachers
    where.missing(:teacher)
  end

  private
  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
