class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  belongs_to :barangay, class_name: "Addresses::Barangay"
  belongs_to :municipality_or_city, class_name: "Addresses::MunicipalityOrCity"
  belongs_to :province, class_name: "Addresses::Province"

  validates :barangay_id, :municipality_or_city_id, :province_id, presence: true
  def details
    if street && barangay && municipality_or_city && province
      "#{street}, #{barangay.name}, #{municipality_or_city.name}, #{province.name}"
    elsif barangay && municipality_or_city && province
      "#{barangay.name}, #{municipality_or_city.name}, #{province.name}"
    end
  end
end
