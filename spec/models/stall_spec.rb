require 'rails_helper'

RSpec.describe Stall, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :public_market }
    it { is_expected.to belong_to :business }
  end
end
