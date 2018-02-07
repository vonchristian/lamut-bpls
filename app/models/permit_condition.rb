class PermitCondition < ApplicationRecord
  validates :content, presence: true

  def self.default
    all.where(default_condition: true)
  end

  def self.set_default(permit)
    default.each do |condition|
      permit.conditions.find_or_create_by(permit_condition: condition)
    end
  end
end
