class Teacher < ApplicationRecord
  extend FriendlyId

  belongs_to :person, dependent: :destroy

  validates :code, presence: true

  friendly_id :code, use: :slugged
  validates :slug, uniqueness: true

  accepts_nested_attributes_for :person

  delegate :name, :age, to: :person, prefix: :person

  private
  def should_generate_new_friendly_id?
    slug.blank? || code_changed?
  end
end
