class RemoveBusinessFromLateRegistrationInterests < ActiveRecord::Migration[5.1]
  def change
    remove_reference :late_registration_interests, :business, foreign_key: true
  end
end
