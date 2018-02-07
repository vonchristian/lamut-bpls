class CreateZoningFees < ActiveRecord::Migration[5.1]
  def change
    create_table :zoning_fees, id: :uuid do |t|
      t.decimal :amount
      t.datetime :calendar_year
      t.belongs_to :business, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
