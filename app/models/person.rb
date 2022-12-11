class Person < ApplicationRecord
  belongs_to :user, dependent: :destroy

  has_one :teacher

  validates :name, :age, presence: true

  accepts_nested_attributes_for :user, reject_if: :all_blank

  delegate :email, to: :user, prefix: :user
end
