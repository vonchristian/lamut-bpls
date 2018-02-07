class RemoveBusinessFromSurcharges < ActiveRecord::Migration[5.1]
  def change
    remove_reference :surcharges, :business, foreign_key: true
  end
end
