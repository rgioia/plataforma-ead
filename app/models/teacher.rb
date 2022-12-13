class Teacher < ApplicationRecord
  extend FriendlyId

  belongs_to :person, dependent: :destroy

  validates :code, presence: true

  friendly_id :code, use: :slugged
  validates :slug, uniqueness: true

  accepts_nested_attributes_for :person

  delegate :name, :age, to: :person, prefix: :person

  def self.order_by_name
    joins(:person).merge(Person.order_by_name)
  end

  private
  def should_generate_new_friendly_id?
    slug.blank? || code_changed?
  end
end
