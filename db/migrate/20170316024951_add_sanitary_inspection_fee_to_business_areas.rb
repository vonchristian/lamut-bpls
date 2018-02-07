class AddSanitaryInspectionFeeToBusinessAreas < ActiveRecord::Migration[5.1]
  def change
    add_reference :business_areas, :sanitary_inspection_fee, foreign_key: true, type: :uuid
  end
end
