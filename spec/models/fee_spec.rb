require 'rails_helper'

describe Fee do
  describe 'associations' do
    it { is_expected.to have_many :business_fees }
    it { is_expected.to have_many :businesses }
  end
  
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of :name }
    it { is_expected.to validate_presence_of :amount }
    it { is_expected.to validate_numericality_of :amount }
  end
  describe '.scopes' do
    it '.default' do
      fee = create(:fee, default_fee: true)
      not_default_fee = create(:fee, default_fee: false)

      expect(Fee.default).to include(fee)
      expect(Fee.default).to_not include(not_default_fee)
    end
    it '.not_default' do
      fee = create(:fee, default_fee: true)
      not_default_fee = create(:fee, default_fee: false)

      expect(Fee.not_default).to_not include(fee)
      expect(Fee.not_default).to include(not_default_fee)
    end
  end
  it '.set_default(business)' do
    fee = create(:fee, default_fee: true)
    not_default_fee = create(:fee, default_fee: false)
    business = create(:business)
    Fee.set_default(business)

    expect(business.fees).to include(fee)
    expect(business.fees).to_not include(not_default_fee)
  end
end
