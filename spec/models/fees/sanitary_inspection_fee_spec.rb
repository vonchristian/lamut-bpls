require 'rails_helper'

module Fees
  describe SanitaryInspectionFee do
    describe 'associations' do
      it { is_expected.to have_many :business_areas}
    end
    describe 'set(business_area)' do
      it "area of 1 to 49.99" do
        business_area = create(:business_area, area: 26)
        sanitary_inspection_fee = create(:sanitary_inspection_fee, minimum_area: 1, maximum_area: 49.99, amount: 55)
        Fees::SanitaryInspectionFee.set(business_area)
        expect(business_area.fee).to eql(55)
      end
      it "area of 50 to 99.99" do
        business_area = create(:business_area, area: 80)
        sanitary_inspection_fee = create(:sanitary_inspection_fee, minimum_area: 50, maximum_area: 99.99, amount: 66)
        Fees::SanitaryInspectionFee.set(business_area)
        expect(business_area.fee).to eql(66)
      end
      it "area of 100 to 499.99" do
        business_area = create(:business_area, area: 180)
        sanitary_inspection_fee = create(:sanitary_inspection_fee, minimum_area: 100, maximum_area: 499.99, amount: 77)
        Fees::SanitaryInspectionFee.set(business_area)
        expect(business_area.fee).to eql(77)
      end
      it "area of 500 to 999.99" do
        business_area = create(:business_area, area: 680)
        sanitary_inspection_fee = create(:sanitary_inspection_fee, minimum_area: 500, maximum_area: 999.99, amount: 88)
        Fees::SanitaryInspectionFee.set(business_area)
        expect(business_area.fee).to eql(88)
      end
      it "area of 1000 or more" do
        business_area = create(:business_area, area: 1180)
        sanitary_inspection_fee = create(:sanitary_inspection_fee, minimum_area: 1000, maximum_area: 9999.99, amount: 110)
        Fees::SanitaryInspectionFee.set(business_area)
        expect(business_area.fee).to eql(110)
      end
    end
    it '#area_range' do
      sanitary_inspection_fee = build(:sanitary_inspection_fee, minimum_area: 1, maximum_area: 10)
      expect(sanitary_inspection_fee.area_range).to eql(1..10)
    end
  end
end
