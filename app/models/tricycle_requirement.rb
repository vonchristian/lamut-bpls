class TricycleRequirement < ApplicationRecord
  belongs_to :department, class_name: "BploSection::Settings::Department"
  validates :name, presence: true, uniqueness: true
  delegate :name, to: :department, prefix: true, allow_nil: true
  def self.not_default
    all.where(default_requirement: false)
  end

  def self.default
    all.where(default_requirement: true)
  end
end
