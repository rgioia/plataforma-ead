class User < ApplicationRecord
  extend Enumerize

  devise :database_authenticatable, :registerable, :recoverable, :validatable

  has_one :person
  accepts_nested_attributes_for :person, reject_if: :all_blank

  validates :email, uniqueness: true
  validates :email, presence: true

  delegate :name, to: :person, prefix: :person

  enumerize :profile, in: { student: 1, teacher: 2, administrator: 3 }, i18n_scope: 'enumerize.user.profile',
            scope: true, default: :student
end
