class Tin < ApplicationRecord
  belongs_to :tinable, polymorphic: true
  validates :number, length: { minimum: 9, maximum: 15 }, allow_blank: true
end
