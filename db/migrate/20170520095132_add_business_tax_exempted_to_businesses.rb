class AddBusinessTaxExemptedToBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_column :businesses, :business_tax_exempted, :boolean, default: false
  end
end
