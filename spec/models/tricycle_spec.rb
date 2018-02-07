require 'rails_helper'

RSpec.describe Tricycle, type: :model do
  context "associations" do 
  	it { is_expected.to belong_to :taxpayer }
  	it { is_expected.to belong_to :tricycle_organization }
  end
end
