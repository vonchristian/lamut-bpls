class CreateRents < ActiveRecord::Migration[5.1]
  def change
    create_table :rents, id: :uuid do |t|
      t.belongs_to :business, foreign_key: true, type: :uuid
      t.decimal :monthly_rent

      t.timestamps
    end
  end
end
