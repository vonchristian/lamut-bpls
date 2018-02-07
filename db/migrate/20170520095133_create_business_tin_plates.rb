class CreateBusinessTinPlates < ActiveRecord::Migration[5.1]
  def change
    create_table :business_tin_plates, id: :uuid do |t|
      t.integer :number
      t.belongs_to :business, foreign_key: true, type: :uuid
      t.belongs_to :business_permit_approval, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
