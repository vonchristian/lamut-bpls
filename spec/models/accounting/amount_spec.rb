require 'rails_helper'

module Accounting
  describe Amount do
    subject { build(:amount) }
    it { is_expected.to_not be_valid }  # construct a child class instead

    describe "validations" do
      it { is_expected.to validate_presence_of :account }
      it { is_expected.to validate_presence_of :entry }
      it { is_expected.to validate_presence_of :type }
      it { is_expected.to validate_presence_of :amount }
      it { is_expected.to validate_numericality_of :amount }
    end
  end
end
