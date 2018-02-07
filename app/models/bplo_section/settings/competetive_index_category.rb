module BploSection
  module Settings
    class CompetetiveIndexCategory < ApplicationRecord
      has_many :line_of_businesses
      has_many :businesses, through: :line_of_businesses
    end
  end
end
