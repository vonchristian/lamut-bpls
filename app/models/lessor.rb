class Lessor < ApplicationRecord
  belongs_to :business
  # validates :full_name, :address, :contact_number, presence: true
end
