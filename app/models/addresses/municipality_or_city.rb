module Addresses
  class MunicipalityOrCity < ApplicationRecord
    belongs_to :province, class_name: "Addresses::Province"
    has_many :barangays, class_name: "Addresses::Barangay"
    has_many :addresses
    has_many :taxpayers, through: :addresses, source: :addressable, source_type: "Taxpayer"
    has_many :businesses, through: :addresses, source: :addressable, source_type: "Business"

  end
end
