class Tricycle < ApplicationRecord
  enum status: [:new_tricycle, :renewed]
  include PgSearch
  pg_search_scope :text_search, :against => [:mtop_number, :plate_number]
  multisearchable :against => [:name, :mtop_number, :plate_number]
  belongs_to :taxpayer
  belongs_to :tricycle_organization
  has_many :applicable_tricycle_fees, class_name: "Tricycles::ApplicableTricycleFee", dependent: :destroy
  has_many :fare_adjustment_fees, class_name: "Fees::FareAdjustmentFee", dependent: :destroy
  has_many :tricycle_permit_applications, class_name: "Tricycles::TricyclePermitApplication", dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :tricycle_fees, through: :applicable_tricycle_fees
  has_many :surcharges, class_name: "Businesses::Surcharge", as: :surchargeable, dependent: :destroy
  has_many :late_registration_interests, class_name: "Businesses::LateRegistrationInterest", as: :interestable, dependent: :destroy
  has_many :applicable_tricycle_requirements, class_name: "Tricycles::ApplicableTricycleRequirement", dependent: :destroy

  validates :mtop_number, :plate_number, presence: true
  delegate :full_name, :contact_number, :full_address, to: :taxpayer, allow_nil: true, prefix: true

  accepts_nested_attributes_for :addresses, :tricycle_permit_applications

  def full_address
    addresses.order(created_at: :asc).last.try(:details)
  end

  def new_transaction?
    tricycle_permit_applications.for_current_year.present? && tricycle_permit_applications.for_current_year.new_application?
  end

  def renew_transaction?
    tricycle_permit_applications.for_current_year.present? && tricycle_permit_applications.for_current_year.renew?
  end
  def self.assessments
    all.collect{|a| a.assessments.total }.sum
  end

  def self.payments
    all.collect{ |a| a.payments.total }.sum
  end

  def payments
    Accounting::Entry.payment.where(commercial_document: self)
  end
  def balance
    assessments.total - payments.total
  end

  def assessments
    Accounting::Entry.assessment.where(commercial_document: self)
  end
  def assessed_for_current_year?
    entry = Accounting::Entry.assessment.where(commercial_document: self).last
		entry.present? && entry.entry_date.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year)
  end
  def status_color
  end
  def total_mayors_permit_fees
    231
  end
  def barangay
    addresses.order(created_at: :asc).last.try(:barangay)
  end
  def total_fees
    tricycle_fees.total +
    fare_adjustment_fees.for_current_year +
    surcharges.for_current_year +
    late_registration_interests.for_current_year
  end
  def name
    " MTOP #: #{mtop_number} - #{taxpayers_full_name}"
  end
  def assessment_details_for_current_year
    entry = Accounting::Entry.assessment.where(commercial_document: self).last
		entry.present? && entry.entry_date.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year)
    entry
  end

  def payment_details_for_current_year
    entry = Accounting::Entry.payment.where(commercial_document: self).last
		entry.present? && entry.entry_date.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year)
    entry
  end

  #show in  entry pdf
  def taxpayers_full_name
    taxpayer_full_name
  end
  def ready_for_approval?
    payment_details_for_current_year.present?
  end

  def late_registration?
      application = tricycle_permit_applications.order(created_at: :asc).last
      application.present? && !application.application_date.between?(BploSection::Settings::PermitApplicationDateRange.order(created_at: :asc).last.start_date, BploSection::Settings::PermitApplicationDateRange.order(created_at: :asc).last.end_date)
  end
  def latest_application_date
    tricycle_permit_applications.order(created_at: :asc).last.application_date
  end

  private
end
