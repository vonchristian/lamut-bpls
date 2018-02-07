require 'rails_helper'

describe Tin do
  describe 'associations' do 
    it { is_expected.to belong_to :tinable }
  end
  describe 'associations' do 
    it { is_expected.to validate_length_of(:number).is_at_least(9).is_at_most(15) }
  end
end
