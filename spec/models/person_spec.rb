require 'rails_helper'

RSpec.describe Person, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:age) }
  it { should have_one(:teacher) }
  it { should belong_to(:user) }
  it { should accept_nested_attributes_for(:user) }

  subject do
    described_class.new(name: 'Rafael Gióia', age: '31', user: User.new(email: Faker::Internet.email, password: '12345678'))
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a email' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
end
