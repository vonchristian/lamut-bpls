class CreateBusinessPermitApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :business_permit_applications, id: :uuid do |t|
      t.belongs_to :business, type: :uuid, foreign_key: true
      t.string :application_number
      t.datetime :application_date

      t.timestamps
    end
    add_index :business_permit_applications, :application_number, unique: true
  end
end
