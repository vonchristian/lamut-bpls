module BploSection
  module Settings
    class Department < ApplicationRecord
      validates :name, presence: true, uniqueness: true
    end
  end
end 
