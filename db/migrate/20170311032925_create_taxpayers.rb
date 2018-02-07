class CreateTaxpayers < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :taxpayers, id: :uuid do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.integer :sex
      t.string :contact_number
      t.string :email, default: ""

      t.timestamps
    end
  end
end
