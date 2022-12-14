class User < ApplicationRecord
  extend Enumerize

  devise :database_authenticatable, :registerable, :recoverable, :validatable

  has_one :person
  accepts_nested_attributes_for :person

  validates :email, uniqueness: true
  validates :email, presence: true

  delegate :name, to: :person, prefix: :person

  enumerize :profile, in: { student: 1, teacher: 2, administrator: 3 }, i18n_scope: 'enumerize.user.profile',
            scope: true, default: :student

  before_validation :set_new_password, on: :create

  after_create :send_reset_password_instructions, if: :created_by_administrator?

  private

  def set_new_password
    self.password = SecureRandom.hex(10) if created_by_administrator?
  end

  def created_by_administrator?
    person&.created_by_administrator
  end
end
