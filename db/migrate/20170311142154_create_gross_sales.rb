class CreateGrossSales < ActiveRecord::Migration[5.1]
  def change
    create_table :gross_sales, id: :uuid do |t|
      t.belongs_to :business_activity, foreign_key: true, type: :uuid
      t.date :calendar_year
      t.decimal :amount

      t.timestamps
    end
  end
end
