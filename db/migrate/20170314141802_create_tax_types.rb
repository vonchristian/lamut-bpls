class CreateTaxTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :tax_types, id: :uuid do |t|
      t.integer :tax_type, default: 0

      t.timestamps
    end
  end
end
