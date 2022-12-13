class Subscription < ApplicationRecord
  extend Enumerize

  belongs_to :person
  belongs_to :course

  validates :status, presence: true
  validates :amount, presence: true
  validates :form_of_payment, presence: true

  enumerize :status, in: { pending: 1, authorized: 2, canceled: 3 },
            i18n_scope: 'enumerize.subscription.status', scope: true, default: :pending

  enumerize :form_of_payment, in: { pix: 1, credit_card: 2, debit_card: 3 },
            i18n_scope: 'enumerize.subscription.form_of_payment', scope: true

  validate :subscriptions_reached_limit, on: :create

  delegate :name, to: :person, prefix: :person

  before_validation :set_amount

  private

  def set_amount
    self.amount = course.price
  end

  def subscriptions_reached_limit
    errors.add(:base, :subscriptions_reached_limit) unless subscription.can_subscribe?
  end
end