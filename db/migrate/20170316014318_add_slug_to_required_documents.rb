class AddSlugToRequiredDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :required_documents, :slug, :string
    add_index :required_documents, :slug, unique: true
  end
end
