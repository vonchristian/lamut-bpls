require 'rails_helper'

describe Taxpayer do
  describe 'associations' do 
    it { is_expected.to have_one :tin }
    it { is_expected.to have_many :taxpayer_businesses }
    it { is_expected.to have_many :businesses }
    it { is_expected.to have_many :addresses }
  end
  describe 'validations' do 
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :middle_name }
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :contact_number }
  end
  describe "enums" do
    it { is_expected.to define_enum_for(:sex).with([:male, :female, :others]) }
  end
  describe 'nested_attributes' do 
    it { is_expected.to accept_nested_attributes_for(:tin) }
  end
end
