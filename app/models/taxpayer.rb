class Taxpayer < ApplicationRecord
  extend FriendlyId
  friendly_id :full_name, use: :slugged
  include PgSearch
  pg_search_scope :text_search, :against => [:last_name, :first_name, :middle_name]
  multisearchable :against => [:last_name, :first_name, :middle_name]

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
  has_one :tin, as: :tinable, dependent: :destroy
  has_many :taxpayer_businesses, class_name: "Taxpayers::TaxpayerBusiness", dependent: :destroy
  has_many :taxpayer_special_permits, dependent: :destroy
  has_many :businesses, through: :taxpayer_businesses
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :tricycles, dependent: :destroy
  enum sex: [:male, :female, :others]
  validates :first_name, :middle_name, :last_name, :contact_number, presence: true
  accepts_nested_attributes_for :tin, :addresses
  def full_name
    "#{first_name} #{middle_name.try(:first).try(:capitalize)}. #{last_name}"
  end
  def full_address
    addresses.order(created_at: :asc).last.try(:details)
  end
  def name
    full_name
  end
  def barangay
    addresses.order(created_at: :asc).last.barangay
  end
  def can_be_destroyed?
    businesses.blank?
  end
end
