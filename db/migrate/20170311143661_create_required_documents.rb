class CreateRequiredDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :required_documents, id: :uuid do |t|
      t.belongs_to :department, foreign_key: true, type: :uuid
      t.string :name
      t.boolean :default_requirement, default: false

      t.timestamps
    end
  end
end
