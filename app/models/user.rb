class User < ApplicationRecord
  extend FriendlyId
  friendly_id :full_name, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:system_administrator,
              :bplo_officer,
              :police_officer,
              :engineering_officer,
              :zoning_officer,
              :collection_officer,
              :fire_safety_officer,
              :mayors_office_staff,
              :application_officer]
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

  belongs_to :department, class_name: "BploSection::Settings::Department"
  validates :first_name, :last_name, :department_id, presence: true

  delegate :name, to: :department, prefix: true

  def full_name
    "#{first_name} #{last_name}"
  end
  def can_issue?(issuance)
    department && department == issuance.department
  end
  def can_accept_payments?
    department == BploSection::Settings::Department.find_by(name: "Municipal Treasury Office") && collection_officer?
  end
end
