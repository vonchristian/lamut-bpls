class Business < ApplicationRecord
  extend FriendlyId
  include PgSearch
  enum status: [:new_business, :renewed, :closed]
  friendly_id :name, use: :slugged
  pg_search_scope :text_search, :against => [:name]
  multisearchable :against => [:name]
  has_attached_file :avatar,
  styles: { large: "120x120>",
            medium: "70x70>",
            thumb: "40x40>",
            small: "30x30>",
            x_small: "20x20>"},
            default_url: ":style/profile_default.jpg",
  :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
  :url => "/system/:attachment/:id/:style/:filename"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  has_one :cockpit_detail, dependent: :destroy
  has_one :tin, as: :tinable, dependent: :destroy
  has_one :business_tin_plate, class_name: "Businesses::BusinessTinPlate", dependent: :destroy
  has_one :employee_count, class_name: "Businesses::EmployeeCount", dependent: :destroy
  has_one :revocation, class_name: "Businesses::BusinessPermits::Revocation", dependent: :destroy
  has_one :business_capital, class_name: "Businesses::BusinessCapital", dependent: :destroy
  has_one :rent, class_name: "Businesses::Rent", dependent: :destroy
  has_one :lessor, dependent: :destroy
  has_one :dti_registration, class_name: "Businesses::DtiRegistration", dependent: :destroy
  has_one :bir_registration, class_name: "Businesses::BirRegistration", dependent: :destroy
  has_one :sec_registration, class_name: "Businesses::SecRegistration", dependent: :destroy
  has_one :cda_registration, class_name: "Businesses::CdaRegistration", dependent: :destroy
  has_one :business_area, class_name: "Businesses::BusinessArea", dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy

  belongs_to :public_market_tenant
  belongs_to :gross_sales_tax_config, class_name: "BploSection::Configurations::GrossSalesTaxConfig"
  belongs_to :ownership_type, class_name: "BploSection::Settings::OwnershipType"
  belongs_to :mode_of_payment, class_name: "BploSection::Settings::ModeOfPayment"
  belongs_to :gross_sales_tax_business_category, class_name: "BploSection::Settings::GrossSalesTaxBusinessCategory"

  has_many :taxpayer_businesses, class_name: "Taxpayers::TaxpayerBusiness", dependent: :destroy
  has_many :taxpayers, through: :taxpayer_businesses
  has_many :business_permit_applications, class_name: "Businesses::BusinessPermits::BusinessPermitApplication", dependent: :destroy
  has_many :business_permit_approvals, class_name: "Businesses::BusinessPermits::BusinessPermitApproval", through: :business_permit_applications, dependent: :destroy
  has_many :gross_sales, class_name: "Businesses::GrossSale", dependent: :destroy
  has_many :business_activities, class_name: "Businesses::BusinessActivity", dependent: :destroy
  has_many :line_of_businesses, through: :business_activities, class_name: "BploSection::Settings::LineOfBusiness"
  has_many :mayors_permit_fees, through: :line_of_businesses, class_name: "Fees::MayorsPermitFee"
  has_many :business_requirements, class_name: "Businesses::BusinessRequirement", dependent: :destroy
  has_many :required_documents, through: :business_requirements, class_name: "BploSection::Settings::RequiredDocument"
  has_many :business_fees, class_name: "Businesses::BusinessFee", dependent: :destroy
  has_many :fees, through: :business_fees
  has_many :storage_permit_fees, through: :business_activities, class_name: "Fees::StoragePermitFee", dependent: :destroy
  has_many :building_permit_fees, class_name: "Fees::BuildingPermitFee", dependent: :destroy
  has_many :electrical_installation_fees, class_name: "Fees::ElectricalInstallationFee", dependent: :destroy
  has_many :plumbing_installation_fees, class_name: "Fees::PlumbingInstallationFee", dependent: :destroy
  has_many :other_accessories_fees, class_name: "Fees::OtherAccessoriesFee", dependent: :destroy
  has_many :engineering_penalties, class_name: "Fees::EngineeringPenalty", dependent: :destroy
  has_many :zoning_fees, class_name: "Fees::ZoningFee", dependent: :destroy
  has_many :sealing_fees, class_name: "Fees::SealingFee", dependent: :destroy
  has_many :annual_inspection_fees, class_name: "Fees::AnnualInspectionFee", dependent: :destroy
  has_many :occupancy_permit_fees, class_name: "Fees::OccupancyPermitFee", dependent: :destroy
  has_many :documentary_stamp_fees, class_name: "Fees::DocumentaryStampFee", dependent: :destroy
  has_many :surcharges, class_name: "Businesses::Surcharge", as: :surchargeable, dependent: :destroy
  has_many :late_registration_interests, class_name: "Businesses::LateRegistrationInterest", as: :interestable, dependent: :destroy
  has_many :fire_safety_inspection_fee_collections, class_name: "Businesses::FireSafetyInspectionFeeCollection", dependent: :destroy
  has_many :entries, class_name: "Accounting::Entry", as: :commercial_document, dependent: :destroy
  has_many :fire_safety_inspection_fees, class_name: "Fees::FireSafetyInspectionFee", dependent: :destroy
  has_many :additional_business_requirements, through: :line_of_businesses, source: :required_documents
  has_many :verifications, through: :business_requirements, class_name: "Businesses::BusinessRequirements::Verification"
  has_many :payment_schedules, dependent: :destroy
  has_many :competetive_index_categories, through: :line_of_businesses

  validates :ownership_type, :mode_of_payment, presence: true
  validates :gross_sales_tax_business_category, presence: true
  validates :name, presence: true

  delegate :semi_annually?, :quarterly?, :annually?, to: :mode_of_payment
  delegate :full_name, :address, :contact_number,  to: :lessor, prefix: true, allow_nil: true
  delegate :name, to: :ownership_type, prefix: true
  delegate :retailer,  :retailer?, to: :gross_sales_tax_business_category
  delegate :per_business?, :per_business_activity?, to: :gross_sales_tax_config, prefix: true, allow_nil: true
  delegate :name, to: :gross_sales_tax_business_category, prefix: true, allow_nil: true
  delegate :fee, to: :business_area, prefix: true, allow_nil: true
  delegate :name, to: :mode_of_payment, prefix: true
  delegate :cooperative?, to: :ownership_type
  delegate :name, to: :ownership_type, prefix: true

  accepts_nested_attributes_for :tin, :business_area, :addresses, :rent, :lessor, :employee_count

  before_save :set_gross_sales_tax_config, :set_owned_by_women
  after_commit :set_default_fees, :set_default_business_requirements, if: :persisted?

  scope :by_ownership, -> (ownership_type_id) { where ownership_type_id: ownership_type_id }

  # def for_fire_department_total
  # end
  def self.in(barangay)
    all.select{|a| a.barangay == barangay}
  end
  def self.single_proprietorship
    by_ownership(BploSection::Settings::OwnershipType.find_by(name: "Single Proprietorship"))
  end
  def single_proprietorship?
    ownership_type && ownership_type.single_proprietorship?
  end
  def barangay
    addresses.last.try(:barangay)
  end

  def owned_by_women?
    taxpayers.female.present?
  end
  def new_business?
    if business_permit_applications.present?
      business_permit_applications.order(created_at: :asc).last.new_application?
    else
      false
    end
  end
  def self.balances
    all.collect{|a| a.balance}.sum
  end
  def self.assessments
    all.collect{|a| a.assessments.total }.sum
  end
  def self.payments
    all.collect{ |a| a.payments.total }.sum
  end
  def self.renewed(options={})
    if options[:from_date] && options[:to_date]
      from_date = options[:from_date].kind_of?(Date) ? options[:from_date] : DateTime.parse(options[:from_date].strftime('%Y/%m/%d'))
      to_date = options[:to_date].kind_of?(Date) ? options[:to_date] : DateTime.parse(options[:to_date].strftime('%Y/%m/%d'))
      includes(:business_permit_approvals).where('business_permit_approvals.date_approved' => from_date..to_date)
    else
      all.not_closed.select {|a| a.business_permit_approvals.for_current_year.present? }
    end
  end
  def self.created_at(options={})
    if options[:from_date] && options[:to_date]
      from_date = options[:from_date].kind_of?(Date) ? options[:from_date] : DateTime.parse(options[:from_date].strftime('%Y/%m/%d'))
      to_date = options[:to_date].kind_of?(Date) ? options[:to_date] : DateTime.parse(options[:to_date].strftime('%Y/%m/%d'))
      where('created_at' => from_date..to_date)
    else
      all
    end
  end

  def self.registered(options={})
    if options[:from_date] && options[:to_date]
      from_date = options[:from_date].kind_of?(Date) ? options[:from_date] : DateTime.parse(options[:from_date].strftime('%Y/%m/%d'))
      to_date = options[:to_date].kind_of?(Date) ? options[:to_date] : DateTime.parse(options[:to_date].strftime('%Y/%m/%d'))
      includes(:business_permit_approvals).where('business_permit_approvals.date_approved' => from_date..to_date)
    else
      all.not_closed.select {|a| a.business_permit_approvals.for_current_year.present? }
    end
  end
  def self.owned_by_women
    all.where(owned_by_women: true)
  end

  def self.closed_between(options={})
    if options[:from_date] && options[:to_date]
      from_date = options[:from_date].kind_of?(Date) ? options[:from_date] : DateTime.parse(options[:from_date].strftime('%Y/%m/%d'))
      to_date = options[:to_date].kind_of?(Date) ? options[:to_date] : DateTime.parse(options[:to_date].strftime('%Y/%m/%d'))
      includes(:revocation).where('revocations.date' => from_date..to_date)
    else
      all.closed
    end
  end
  def self.unrenewed
    all.not_closed.select {|a| a.unrenewed? }
  end
  def self.closed
    all.select{|a| a.revocation.present? }
  end
  def self.not_closed
    all.select{|a| !a.closed? }

  end
  def unrenewed?
    business_permit_approvals.for_current_year.blank?
  end
  def permit_number
    business_permit_approvals.for_current_year.last.try(:permit_number)
  end
  def application_number
    business_permit_applications.for_current_year.last.try(:application_number)
  end

  def taxpayers_full_name
    taxpayers.distinct.map{|a| a.full_name}.join(",")
  end
  def taxpayers_gender
    taxpayers.distinct.map{|a| a.sex}.join(",")
  end
  def taxpayers_address
    taxpayers.distinct.map{|a| a.full_address}.join(",")
  end
  def taxpayers_contact_number
    taxpayers.distinct.map{|a| a.contact_number}.join(",")
  end

  def payments
    Accounting::Entry.payment.where(commercial_document: self)
  end

  def assessments
    Accounting::Entry.assessment.where(commercial_document: self)
  end
  def balance
    assessments.total - payments.total
  end


  def assessed_for_current_year?
    entry = Accounting::Entry.assessment.where(commercial_document: self).last
		entry.present? && entry.entry_date.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year)
  end

  def full_address
    addresses.try(:last).try(:details)
  end
  def submitted_all_requirements?
    business_requirements.verified?
  end

  def has_storage_permit_fee?
    storage_permit_fees.present?
  end


  def total_fees
    total_default_fees +
    total_mayors_permit_fees +
    total_sanitary_inspection_fee +
    total_building_permit_fees +
    total_zoning_fees +
    total_storage_permit_fees +
    total_annual_inspection_fees +
    total_occupancy_permit_fees +
    total_documentary_stamp_fees +
    total_cockpit_operation_fees +
    total_electrical_installation_fees +
    total_plumbing_installation_fees +
    total_other_accessories_fees +
    total_engineering_penalties +
    total_sealing_fees
  end
  def total_cockpit_operation_fees
    CockpitPersonnelFee.assessment_for(self)
  end
  def total_other_accessories_fees
    Fees::OtherAccessoriesFee.assessment_for(self)
  end

  def total_sealing_fees
    Fees::SealingFee.assessment_for(self)
  end

  def total_engineering_penalties
    Fees::EngineeringPenalty.assessment_for(self)
  end


  def total_default_fees
    Fee.assessment_for(self)
  end

  def total_building_permit_fees
    Fees::BuildingPermitFee.assessment_for(self)
  end

  def total_electrical_installation_fees
    Fees::ElectricalInstallationFee.assessment_for(self)
  end

  def total_plumbing_installation_fees
    Fees::PlumbingInstallationFee.assessment_for(self)
  end

  def total_mayors_permit_fees
    Fees::MayorsPermitFee.assessment_for(self)
  end
  def total_sanitary_inspection_fee
    Fees::SanitaryInspectionFee.assessment_for(self)
  end

  def total_storage_permit_fees
    0
  end

  def total_zoning_fees
    Fees::ZoningFee.assessment_for(self)
  end

  def total_annual_inspection_fees
    Fees::AnnualInspectionFee.assessment_for(self)
  end
  def total_occupancy_permit_fees
    Fees::OccupancyPermitFee.assessment_for(self)
  end

  def total_documentary_stamp_fees
    Fees::DocumentaryStampFee.assessment_for(self)
  end

  def total_gross_sales_taxes
    gross_sales.total_tax
  end
  def total_taxes
    Businesses::GrossSale.assessment_for(self)
  end
  def total_business_taxes
    Businesses::GrossSale.assessment_for(self)
  end

  def total_fees_and_taxes
    total_fees + total_taxes + total_surcharges + total_interests
  end
  def total_surcharges
    Businesses::Surcharge.assessment_for(self)
  end

  def total_interests
    Businesses::LateRegistrationInterest.assessment_for(self)
  end

  def line_of_businesses_name
    line_of_businesses.pluck(:name).join(",")
  end
  def set_default_fees
    Fee.set_default(self)
  end

  def set_default_business_requirements
    BploSection::Settings::RequiredDocument.set_default_requirements(self)
  end

  def gross_sales_entered_on?(year)
    if gross_sales.present?
      gross_sales.each.map{|a| a.calendar_year.year}.include?(year)
    else
      false
    end
  end
  def business_status
    if closed?
      "Closed"
    elsif unrenewed? && business_permit_approvals.blank?
      "No Permit Yet"
    elsif unrenewed? && business_permit_approvals.present?
      "Unrenewed"
    elsif business_type == "New Application"
      "New"
    elsif business_type == "Renew"
      "Renew"
    end
  end
  def status_color
    if closed?
      'red'
    elsif unrenewed?
      'yellow'
    else
      'green'
    end
  end

  def default_payment_amount
    if payment_schedules.present?
      payment_schedules.for_current_year.first.try(:amount) + total_fees
    else
      balance
    end
  end

  def business_type
    business_permit_applications.order(:created_at).last.try(:transaction_type).try(:titleize)
  end
  def rented?
    business_area && business_area.rented?
  end
  def exempted(fee)
  end
  def assessment_details_for_current_year
    entry = self.assessments.select{|a| a.entry_date.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year) }
    entry.first
  end
  def payment_details_for_current_year
    entry = self.payments.select{|a| a.entry_date.between?(Time.zone.now.beginning_of_year, Time.zone.now.end_of_year) }
    entry.first
  end
  def set_gross_sales_tax_config
    BploSection::Configurations::GrossSalesTaxConfig.set_default(self)
  end


  def late_registration?
      application = business_permit_applications.order(application_date: :asc).last
      application.present? && !application.application_date.between?(BploSection::Settings::PermitApplicationDateRange.order(created_at: :asc).last.start_date, BploSection::Settings::PermitApplicationDateRange.order(created_at: :asc).last.end_date)
  end
  def ready_for_approval?
    if self.transient?
      payment_details_for_current_year.present?
    else
      payment_details_for_current_year.present? && fire_dept_collected?
    end
  end
  def fire_dept_collected?
    entries.each do |entry|
      FireDeptCollection.all.where(entry: entry).present?
    end
    # payment_details_for_current_year && payment_details_for_current_year.fire_dept_collection.present?
  end
  def date_registered
    approved = business_permit_approvals.order(:created_at => "asc").last
    if approved.present?
      approved.date_approved.strftime("%B %e, %Y")
    end
  end
  def latest_application_date
    business_permit_applications.order(created_at: :asc).last.application_date
  end
  def business_tax_payments
    amount = []
    payments.for_current_year.each do |payment|
      amount << payment.credit_amounts.where(account: Accounting::Account.find_by_name("Accounts Receivable - Business Tax")).sum(&:amount)
    end
    amount.sum
  end
  def cockpit?
    line_of_businesses.pluck(:name).include?("Cockpit Operation")
  end
  def fees_not_assessed_for_current_year
    Fee.not_assessed_for_current_year(self)
  end
  def transient?
    public_market_tenant && public_market_tenant.transient?
  end
  def self.not_transient
    all.select{|a| !a.transient? }
  end

  private
  def set_owned_by_women
    if taxpayers.female.present?
      self.owned_by_women = true
    end
  end

end
