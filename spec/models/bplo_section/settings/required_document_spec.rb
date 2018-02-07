require 'rails_helper'

module BploSection
  module Settings
    describe RequiredDocument, type: :model do
      describe 'associations' do
        it { is_expected.to belong_to :department }
      end
      describe "validations" do
        it { is_expected.to validate_presence_of :name }
        it { is_expected.to validate_uniqueness_of :name }
      end
      describe 'delegations' do
        it { is_expected.to delegate_method(:name).to(:department).with_prefix }
      end
      describe 'scopes' do
        it ".default" do
          required_document_1 = create(:required_document, default_requirement: true)
          required_document_2 = create(:required_document, default_requirement: false)

          expect(BploSection::Settings::RequiredDocument.default).to include(required_document_1)
          expect(BploSection::Settings::RequiredDocument.default).to_not include(required_document_2)
        end
      end
    end
  end
end
