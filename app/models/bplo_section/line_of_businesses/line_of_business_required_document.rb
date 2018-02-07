module BploSection
  module LineOfBusinesses
    class LineOfBusinessRequiredDocument < ApplicationRecord
      belongs_to :line_of_business, class_name: "BploSection::Settings::LineOfBusiness"
      belongs_to :required_document, class_name: "BploSection::Settings::RequiredDocument"
    end
  end
end
