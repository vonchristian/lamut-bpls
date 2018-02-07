require 'rails_helper'

describe Lessor, type: :model do
  describe 'associations' do 
    it { is_expected.to have_many :businesses }
  end 
  describe 'validations' do 
    # it { is_expected.to validate_presence_of(:full_name) }
    # it { is_expected.to validate_presence_of :address }
    # it { is_expected.to validate_presence_of :contact_number }
  end
end
