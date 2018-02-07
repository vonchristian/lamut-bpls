class CreateAnnualInspectionFees < ActiveRecord::Migration[5.1]
  def change
    create_table :annual_inspection_fees, id: :uuid do |t|
      t.belongs_to :business, foreign_key: true, type: :uuid
      t.decimal :amount
      t.datetime :calendar_year

      t.timestamps
    end
  end
end
