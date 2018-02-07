class CreateOtherAccessoriesFees < ActiveRecord::Migration[5.1]
  def change
    create_table :other_accessories_fees, id: :uuid do |t|
      t.belongs_to :business, foreign_key: true, type: :uuid
      t.datetime :calendar_year
      t.decimal :amount

      t.timestamps
    end
  end
end
