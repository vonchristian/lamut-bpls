class Fee < ApplicationRecord
  belongs_to :debit_account, class_name: "Accounting::Account"
  belongs_to :credit_account, class_name: "Accounting::Account"

  validates :name, presence: true, uniqueness: true
  validates :amount, presence: true, numericality: true
  validates :credit_account_id, :debit_account_id, presence: true
  has_many :business_fees, class_name: "Businesses::BusinessFee", dependent: :destroy
  has_many :businesses, through: :business_fees
  after_commit :update_businesses
  delegate :name, to: :account, prefix: true, allow_nil: true
  def self.total
    all.sum(:amount)
  end
  def self.unpaid_fees_for(business)
    all.select{|a| !a.already_paid_by?(business) }
  end

  def self.not_assessed_for_current_year(business)
      business.assessment_details_for_current_year
  end
  def self.default
    all.where(default_fee: true)
  end

  def already_paid_by?(business)
    payment = credit_account.credit_entries.where(commercial_document: business)
    payment.present?
  end
  def self.assessment_for(business)
    business.fees.unpaid_fees_for(business).sum(&:amount)
  end

  def self.not_default
    all.where(default_fee: false)
  end

  def self.set_default(business)
    all.default.each do |fee|
      business.business_fees.find_or_create_by(fee: fee)
    end
  end

  def self.remove_default_fee(business, fee)
    business.business_fees.where(fee: fee).delete_all
  end

  private

  def update_businesses
    if default_fee
      Business.all.each do |business|
        Fee.set_default(business)
      end
    elsif !default_fee
      businesses.each do |business|
        Fee.remove_default_fee(business, self)
      end
    end
  end
end
