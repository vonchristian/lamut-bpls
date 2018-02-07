class CreateSurcharges < ActiveRecord::Migration[5.1]
  def change
    create_table :surcharges, id: :uuid do |t|
      t.decimal :amount
      t.belongs_to :business, foreign_key: true, type: :uuid
      t.references :s, polymorphic: true, index: true, type: :uuid
      t.datetime :date

      t.timestamps
    end
  end
end
