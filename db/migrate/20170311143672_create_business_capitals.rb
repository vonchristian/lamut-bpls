class CreateBusinessCapitals < ActiveRecord::Migration[5.1]
  def change
    create_table :business_capitals, id: :uuid do |t|
      t.decimal :amount
      t.belongs_to :business, foreign_key: true, type: :uuid
      t.decimal :tax_amount
      t.timestamps
    end
  end
end
