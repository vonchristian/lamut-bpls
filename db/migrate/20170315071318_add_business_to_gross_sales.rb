class AddBusinessToGrossSales < ActiveRecord::Migration[5.1]
  def change
    add_reference :gross_sales, :business, foreign_key: true, type: :uuid
  end
end
