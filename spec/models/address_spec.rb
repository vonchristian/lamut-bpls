require 'rails_helper'

describe Address do
  describe 'associations' do
    it { is_expected.to belong_to :addressable }
    it { is_expected.to belong_to :province }
    it { is_expected.to belong_to :municipality_or_city }
    it { is_expected.to belong_to :barangay }
  end
  describe 'validations' do
    it { is_expected.to validate_presence_of :barangay_id }
    it { is_expected.to validate_presence_of :municipality_or_city_id }
    it { is_expected.to validate_presence_of :province_id }
  end
  context '#details' do 
    it 'street, barangay, municipality_or_city and province is present' do 
      barangay = create(:barangay, name: 'Poblacion West')
      municipality_or_city = create(:municipality_or_city, name: 'Lamut')
      province = create(:province, name: 'Ifugao')
      address = create(:address, street: 'Poblacion West', barangay: barangay, municipality_or_city: municipality_or_city,  province: province )
      
      expect(address.details).to eql("Poblacion West, Poblacion West, Lamut, Ifugao")
    end
    it 'barangay, municipality_or_city and province is present' do 
      barangay = create(:barangay, name: 'Poblacion West')
      municipality_or_city = create(:municipality_or_city, name: 'Lamut')
      province = create(:province, name: 'Ifugao')
      address = create(:address, street: nil, barangay: barangay, municipality_or_city: municipality_or_city,  province: province )
      
      expect(address.details).to eql("Poblacion West, Lamut, Ifugao")
    end
  end
end
