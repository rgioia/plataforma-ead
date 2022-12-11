class Person < ApplicationRecord
  belongs_to :user, dependent: :destroy

  has_one :teacher

  validates :name, :age, presence: true

  accepts_nested_attributes_for :user

  delegate :email, to: :user, prefix: :user

  attr_accessor :created_by_administrator

  def self.not_teachers
    where.missing(:teacher)
  end
end
