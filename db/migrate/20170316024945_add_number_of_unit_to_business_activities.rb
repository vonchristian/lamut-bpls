class AddNumberOfUnitToBusinessActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :business_activities, :number_of_unit, :integer, default: 1
  end
end
