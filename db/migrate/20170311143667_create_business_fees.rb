class CreateBusinessFees < ActiveRecord::Migration[5.1]
  def change
    create_table :business_fees, id: :uuid do |t|
      t.belongs_to :business, foreign_key: true, type: :uuid
      t.belongs_to :fee, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
