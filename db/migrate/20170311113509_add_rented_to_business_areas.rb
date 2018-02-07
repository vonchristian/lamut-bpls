class AddRentedToBusinessAreas < ActiveRecord::Migration[5.1]
  def change
    add_column :business_areas, :rented, :boolean, default: false
  end
end
