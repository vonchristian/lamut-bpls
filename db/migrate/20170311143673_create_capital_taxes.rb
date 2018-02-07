class CreateCapitalTaxes < ActiveRecord::Migration[5.1]
  def change
    create_table :capital_taxes, id: :uuid do |t|
      t.decimal :rate

      t.timestamps
    end
  end
end
