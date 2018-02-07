class CreateBusinessRequirements < ActiveRecord::Migration[5.1]
  def change
    create_table :business_requirements, id: :uuid do |t|
      t.belongs_to :required_document, foreign_key: true, type: :uuid
      t.belongs_to :business, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
