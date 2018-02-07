class TricycleFee < ApplicationRecord
  belongs_to :debit_account, class_name: "Accounting::Account"
  belongs_to :credit_account, class_name: "Accounting::Account"
  NEW_APPLICANT_FEES = ["Filing Fee", "MTOP Plate"]
  RENEW_APPLICANT_FEES = ["Sticker Fee"]
  validates :name, :amount, presence: true
  validates :name, uniqueness: true

  def self.default
    all.where(default_fee: true)
  end

  def self.not_default
    all.where(default_fee: false)
  end
  def self.total
    sum(:amount)
  end
  def self.for_new_applicants
    select{ |a| NEW_APPLICANT_FEES.include?(a.name) }
  end

  def self.for_renew_applicants
    select{ |a| RENEW_APPLICANT_FEES.include?(a.name) }
  end
end
