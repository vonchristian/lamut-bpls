module Addresses
  class Barangay < ApplicationRecord
    BARANGAYS = [
      "Ambasa",
      "Bimpal",
      "Hapid",
      "Holowon",
      "Lawig",
      "Lucban",
      "Mabatobato",
      "Magulon",
      "Nayon",
      "Panopdopan",
      "Payawan",
      "Pieza",
      "Poblacion East",
      "Poblacion West",
      "Pugol",
      "Salamague",
      "Sanafe",
      "Umilag",
    ]
    belongs_to :municipality_or_city, class_name: "Addresses::MunicipalityOrCity"
    has_many :addresses
    has_many :businesses, through: :addresses, source: :addressable, source_type: "Business"
    has_many :taxpayers, through: :addresses, source: :addressable, source_type: "Taxpayer"
    has_many :tricycles, through: :addresses, source: :addressable, source_type: "Tricycle"


    delegate :name, to: :municipality_or_city, prefix: true

    has_attached_file :logo,
    styles: { large: "120x120>",
              medium: "70x70>",
              thumb: "40x40>",
              small: "30x30>",
              x_small: "20x20>"},
              default_url: ":style/profile_default.jpg",
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

    validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
    def self.in_lamut
      all.select{ |a| Addresses::Barangay::BARANGAYS.include?(a.name) }
    end
  end
end
