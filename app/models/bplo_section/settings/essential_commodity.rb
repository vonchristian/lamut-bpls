module BploSection
  module Settings
    class EssentialCommodity < ApplicationRecord
      validates :name, presence: true, uniqueness: true
    end
  end
end
