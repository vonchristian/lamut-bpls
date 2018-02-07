require 'rails_helper'
module Businesses
  module BusinessPermits
    describe BusinessPermitApproval do
      describe 'associations' do
        it { is_expected.to belong_to :business_permit_application }
      end
    end
  end
end
