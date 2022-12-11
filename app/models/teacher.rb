class Teacher < ApplicationRecord
  belongs_to :person, dependent: :destroy

  validates :code, presence: true

  accepts_nested_attributes_for :person

  delegate :name, :age, to: :person, prefix: :person
end
