module BploSection
  module Settings
    class MayorsPermitFeeBusinessCategory < ApplicationRecord
      has_many :line_of_businesses, class_name: "BploSection::Settings::LineOfBusiness"
    end
  end 
end 
