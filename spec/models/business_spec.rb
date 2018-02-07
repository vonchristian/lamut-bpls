require 'rails_helper'

describe Business do
  describe 'associations' do
    it { is_expected.to have_one :cockpit_detail }
    it { is_expected.to have_one :tin }
    it { is_expected.to have_one :business_tin_plate }
    it { is_expected.to have_one :employee_count }
    it { is_expected.to have_one :revocation }
    it { is_expected.to have_one :business_capital }
    it { is_expected.to have_one :rent }
    it { is_expected.to have_one :lessor }
    it { is_expected.to have_one :dti_registration }
    it { is_expected.to have_one :bir_registration }
    it { is_expected.to have_one :sec_registration }
    it { is_expected.to have_one :cda_registration }
    it { is_expected.to have_one :business_area }
    it { is_expected.to have_one :address }


    it { is_expected.to belong_to :public_market_tenant }
    it { is_expected.to belong_to :gross_sales_tax_config }
    it { is_expected.to belong_to :ownership_type }
    it { is_expected.to belong_to :mode_of_payment }
    it { is_expected.to belong_to :gross_sales_tax_business_category }

    it { is_expected.to have_many :taxpayer_businesses }
    it { is_expected.to have_many :taxpayers }
    it { is_expected.to have_many :business_permit_applications }
    it { is_expected.to have_many :business_permit_approvals }
    it { is_expected.to have_many :gross_sales }
    it { is_expected.to have_many :business_activities }
    it { is_expected.to have_many :line_of_businesses }
    it { is_expected.to have_many :mayors_permit_fees }
    it { is_expected.to have_many :business_requirements }
    it { is_expected.to have_many :required_documents }
    it { is_expected.to have_many :business_fees }
    it { is_expected.to have_many :fees }
    it { is_expected.to have_many :storage_permit_fees }
    it { is_expected.to have_many :building_permit_fees }
    it { is_expected.to have_many :electrical_installation_fees }
    it { is_expected.to have_many :plumbing_installation_fees }
    it { is_expected.to have_many :other_accessories_fees }
    it { is_expected.to have_many :engineering_penalties }
    it { is_expected.to have_many :zoning_fees }
    it { is_expected.to have_many :sealing_fees }
    it { is_expected.to have_many :annual_inspection_fees }
    it { is_expected.to have_many :occupancy_permit_fees }
    it { is_expected.to have_many :documentary_stamp_fees }
    it { is_expected.to have_many :surcharges }
    it { is_expected.to have_many :late_registration_interests }
    it { is_expected.to have_many :fire_safety_inspection_fee_collections }
    it { is_expected.to have_many :entries }
    it { is_expected.to have_many :fire_safety_inspection_fees }
    it { is_expected.to have_many :additional_business_requirements }
    it { is_expected.to have_many :verifications }
    it { is_expected.to have_many :payment_schedules }
    it { is_expected.to have_many :competetive_index_categories }
  end
  describe 'validations' do
    it { is_expected.to validate_presence_of :ownership_type }
    it { is_expected.to validate_presence_of :mode_of_payment }
    it { is_expected.to validate_presence_of :gross_sales_tax_business_category}
    it { is_expected.to validate_presence_of :name }
  end
  describe 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:address) }
    it { is_expected.to accept_nested_attributes_for(:business_area) }
    it { is_expected.to accept_nested_attributes_for(:rent) }
    it { is_expected.to accept_nested_attributes_for(:lessor) }
    it { is_expected.to accept_nested_attributes_for(:tin) }
  end
  describe 'delegations' do
    it { is_expected.to delegate_method(:name).to(:gross_sales_tax_business_category).with_prefix }
    it { is_expected.to delegate_method(:retailer).to(:gross_sales_tax_business_category) }
    it { is_expected.to delegate_method(:per_business?).to(:gross_sales_tax_config).with_prefix }
    it { is_expected.to delegate_method(:per_business_activity?).to(:gross_sales_tax_config).with_prefix }
    it { is_expected.to delegate_method(:name).to(:mode_of_payment).with_prefix}

  end
  describe "fees computation" do
    it 'total_default_fees' do
      business = create(:business)
      fee_1 = create(:fee, amount: 50, default_fee: true)
      fee_2 = create(:fee, amount: 150, default_fee: true)
      Fee.set_default(business)

      expect(business.total_default_fees).to eql(200)
    end

    it 'default fees with mayors permit fee' do
      business = create(:business)
      fee_1 = create(:fee, amount: 10, default_fee: true)
      fee_2 = create(:fee, amount: 20, default_fee: true)
      Fee.set_default(business)
      mayors_permit_fee = create(:mayors_permit_fee, amount: 100)
      line_of_business = create(:line_of_business, mayors_permit_fee: mayors_permit_fee)
      business_activity = create(:business_activity, business: business, line_of_business: line_of_business)

      expect(business.total_fees).to eql(130)
    end
    it 'with mayors permit fees and sanitary_inspection_fee' do
      business = create(:business)
      fee_1 = create(:fee, amount: 50, default_fee: true)
      fee_2 = create(:fee, amount: 150, default_fee: true)

      mayors_permit_fee = create(:mayors_permit_fee, amount: 100)
      line_of_business = create(:line_of_business, mayors_permit_fee: mayors_permit_fee)
      business_activity = create(:business_activity, business: business, line_of_business: line_of_business)
      business_area = create(:business_area, area: 80, business: business)
      sanitary_inspection_fee = create(:sanitary_inspection_fee, minimum_area: 50, maximum_area: 99.99, amount: 66)
      Fee.set_default(business)
      Fees::SanitaryInspectionFee.set(business_area)
      expect(business_area.fee).to eql(66)


      expect(business.total_fees).to eql(366)
    end
    it 'fees with mayors permit fees, sanitary_inspection_fee and storage_permit_fees' do
      business = create(:business)
      fee_1 = create(:fee, amount: 25, default_fee: true)
      fee_2 = create(:fee, amount: 55, default_fee: true)

      storage_permit_fee = create(:storage_permit_fee, minimum_value: 500, maximum_value: 1000, amount: 700)

      sanitary_inspection_fee = create(:sanitary_inspection_fee, minimum_area: 50, maximum_area: 99.99, amount: 100)

      mayors_permit_fee = create(:mayors_permit_fee, amount: 120)

      line_of_business = create(:line_of_business, mayors_permit_fee: mayors_permit_fee, has_storage_permit_fee: true)

      business_activity = create(:business_activity, business: business, line_of_business: line_of_business, volume: 690)

      business_area = create(:business_area, area: 80, business: business)
      Fee.set_default(business)
      Fees::SanitaryInspectionFee.set(business_area)
      Fees::StoragePermitFee.set(business_activity)

      expect(business.total_default_fees).to eql(80)
      expect(business_area.fee).to eql(100)
      expect(business_activity.storage_permit_fee_amount).to eql(700)

      expect(business.total_fees).to eql(1000)
    end
  end
  it ".total_gross_sales_taxes" do
  end
end
