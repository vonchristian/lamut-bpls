class CreateBuildingPermitFees < ActiveRecord::Migration[5.1]
  def change
    create_table :building_permit_fees, id: :uuid do |t|
      t.decimal :amount
      t.belongs_to :business, foreign_key: true, type: :uuid
      t.datetime :calendar_year

      t.timestamps
    end
  end
end
