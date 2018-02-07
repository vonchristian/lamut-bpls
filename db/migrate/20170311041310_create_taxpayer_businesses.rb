class CreateTaxpayerBusinesses < ActiveRecord::Migration[5.1]
  def change
    create_table :taxpayer_businesses, id: :uuid do |t|
      t.belongs_to :business, type: :uuid, foreign_key: true
      t.belongs_to :taxpayer, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
