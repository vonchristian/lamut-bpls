class CreateTaxpayerSpecialPermits < ActiveRecord::Migration[5.1]
  def change
    create_table :taxpayer_special_permits, id: :uuid do |t|
      t.belongs_to :special_permit, foreign_key: true, type: :uuid
      t.belongs_to :taxpayer, foreign_key: true, type: :uuid
      t.decimal :number_of_days
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :amount
      t.string :location

      t.timestamps
    end
  end
end
