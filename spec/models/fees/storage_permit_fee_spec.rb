require 'rails_helper'

module Fees
  describe StoragePermitFee do
    describe 'associations' do
    end
    describe 'validations' do
    end
    describe 'set(business_activity)' do
      it "volume of 500 liters to 2,000 liters" do
        business_activity = create(:business_activity, volume: 500)
        storage_permit_fee = create(:storage_permit_fee, minimum_value: 500, maximum_value: 2000, amount: 1100)
        Fees::StoragePermitFee.set(business_activity)
        expect(business_activity.storage_permit_fee_amount).to eql(1100)
      end
      it "volume of 2,001 liters to 5,000 liters" do
        business_activity = create(:business_activity, volume: 2001)
        storage_permit_fee = create(:storage_permit_fee, minimum_value: 2001, maximum_value: 5000, amount: 1_650)
        Fees::StoragePermitFee.set(business_activity)
        expect(business_activity.storage_permit_fee_amount).to eql(1650)
      end
      it "volume of 5,001 liters to 20,000 liters" do
        business_activity = create(:business_activity, volume: 5001)
        storage_permit_fee = create(:storage_permit_fee, minimum_value: 5001, maximum_value: 20_000, amount: 2_200)
        Fees::StoragePermitFee.set(business_activity)
        expect(business_activity.storage_permit_fee_amount).to eql(2_200)
      end
      it "volume of 20,001 liters to 50,000 liters" do
        business_activity = create(:business_activity, volume: 20_001)
        storage_permit_fee = create(:storage_permit_fee, minimum_value: 20_001, maximum_value: 50_000, amount: 2750)
        Fees::StoragePermitFee.set(business_activity)
        expect(business_activity.storage_permit_fee_amount).to eql(2750)
      end
      it "volume of 50_001 liters to 100_000 liters" do
        business_activity = create(:business_activity, volume: 50_001)
        storage_permit_fee = create(:storage_permit_fee, minimum_value: 50_001, maximum_value: 100_000, amount: 3300)
        Fees::StoragePermitFee.set(business_activity)
        expect(business_activity.storage_permit_fee_amount).to eql(3300)
      end
      it "volume of 100_000 liters or more" do
        business_activity = create(:business_activity, volume: 100_000)
        storage_permit_fee = create(:storage_permit_fee, minimum_value: 100_000, maximum_value: 100_000_000, amount: 4400)
        Fees::StoragePermitFee.set(business_activity)
        expect(business_activity.storage_permit_fee_amount).to eql(4400)
      end
    end
    it '#volume_range' do
      storage_permit_fee = build(:storage_permit_fee, minimum_value: 1, maximum_value: 10)
      expect(storage_permit_fee.volume_range).to eql(1..10)
    end
  end
end
