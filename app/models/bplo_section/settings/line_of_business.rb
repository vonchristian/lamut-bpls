module BploSection
  module Settings
    class LineOfBusiness < ApplicationRecord
      extend FriendlyId
      include PgSearch
      pg_search_scope :text_search, :against => [:name]
      friendly_id :name, use: :slugged
      has_one :mayors_permit_fee, class_name: "Fees::MayorsPermitFee"
      belongs_to :competetive_index_category, class_name: "BploSection::Settings::CompetetiveIndexCategory"
      belongs_to :mayors_permit_fee_business_category, class_name: "BploSection::Settings::MayorsPermitFeeBusinessCategory"
      has_many :line_of_business_required_documents, class_name: "BploSection::LineOfBusinesses::LineOfBusinessRequiredDocument"
      has_many :required_documents, through: :line_of_business_required_documents, class_name: "BploSection::Settings::RequiredDocument"

      has_many :business_activities, class_name: "Businesses::BusinessActivity"
      has_many :businesses, through: :business_activities

      validates :name, presence: true, uniqueness: true

      accepts_nested_attributes_for :mayors_permit_fee

      delegate :amount, to: :mayors_permit_fee, prefix: true
      delegate :name, to: :mayors_permit_fee_business_category, prefix: true

      scope :highest_rated, -> { where("line_of_businesses.id in (select line_of_business_id from business_activities)").group('line_of_businesses.id').joins(:business_activities).order('(business_activities.count) DESC') }

    end
  end
end
