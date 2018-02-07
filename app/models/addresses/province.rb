module Addresses
  class Province < ApplicationRecord
    has_many :municipality_or_cities, class_name: "Addresses::MunicipalityOrCity"
  end
end