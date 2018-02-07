class CreateLineOfBusinessRequiredDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :line_of_business_required_documents, id: :uuid do |t|
      t.belongs_to :line_of_business, foreign_key: true, type: :uuid, index: { name: "index_on_line_of_business_required_documents" }
      t.belongs_to :required_document, foreign_key: true, type: :uuid, index: { name: "index_on_required_document_required_documents" }

      t.timestamps
    end
  end
end
