class CreateGrossSalesTaxConfigs < ActiveRecord::Migration[5.1]
  def change
    create_table :gross_sales_tax_configs, id: :uuid do |t|
      t.integer :tax_config, default: 0

      t.timestamps
    end
  end
end
