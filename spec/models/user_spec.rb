require 'rails_helper'

RSpec.describe User, type: :model do

  it { should validate_presence_of(:email) }
  it { should have_one(:person) }
  it { should accept_nested_attributes_for(:person) }

  subject {
    described_class.new(email: Faker::Internet.email, password: '12345678')
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end
end
