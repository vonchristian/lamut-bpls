class FireDeptCollection < ApplicationRecord
  include PgSearch
  pg_search_scope :text_search, :against => [:reference_number]
  belongs_to :entry, class_name: "Accounting::Entry"
  belongs_to :collector, class_name: "User"

  has_one :fire_safety_inspection_fee, class_name: "Fees::FireSafetyInspectionFee", dependent: :destroy
  has_one :storage_fee, dependent: :destroy
  has_one :conveyance_clearance_fee, dependent: :destroy
  has_one :installation_clearance_fee, dependent: :destroy
  has_one :fire_code_fine, dependent: :destroy
  has_one :construction_tax, dependent: :destroy

  accepts_nested_attributes_for :fire_safety_inspection_fee, :storage_fee, :conveyance_clearance_fee, :installation_clearance_fee, :fire_code_fine, :construction_tax

  before_save :set_default_date

  validates :reference_number, presence: true 
  def total
    fire_safety_inspection_fee_total +
    storage_fee_total +
    conveyance_clearance_fee_total +
    installation_clearance_fee_total +
    fire_code_fine_total +
    construction_tax_total
  end
  def fire_safety_inspection_fee_total
    if fire_safety_inspection_fee.present?
      fire_safety_inspection_fee.amount
    else
      0
    end
  end

  def storage_fee_total
    if storage_fee.present?
      storage_fee.amount
    else
      0
    end
  end
  def conveyance_clearance_fee_total
    if conveyance_clearance_fee.present?
      conveyance_clearance_fee.amount
    else
      0
    end
  end
  def installation_clearance_fee_total
    if installation_clearance_fee.present?
      installation_clearance_fee.amount
    else
      0
    end
  end
  def fire_code_fine_total
    if fire_code_fine.present?
      fire_code_fine.amount
    else
      0
    end
  end
  def construction_tax_total
    if construction_tax.present?
      construction_tax.amount
    else
      0
    end
  end
  private
  def set_default_date
    self.entry_date ||= Time.zone.now
  end
end
