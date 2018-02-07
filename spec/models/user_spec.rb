require 'rails_helper'

describe User do
  describe 'associations' do
    it { is_expected.to belong_to :department }
  end
  describe 'validations' do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
  end

  it '#full_name' do
    user = build(:user, first_name: 'Von', last_name: 'Halip')

    expect(user.full_name).to eql('Von Halip')
  end
end
