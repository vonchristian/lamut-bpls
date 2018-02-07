class AddTricycleOrganizationToTricycles < ActiveRecord::Migration[5.1]
  def change
    add_reference :tricycles, :tricycle_organization, foreign_key: true, type: :uuid
  end
end
