module Businesses
  class EmployeeCount < ApplicationRecord
    belongs_to :business
    validates :number, presence: true, numericality: true
  end
end