class AddCommercialDocumentToAmounts < ActiveRecord::Migration[5.1]
  def change
    add_reference :amounts, :commercial_document, polymorphic: true, type: :uuid, index: { name: "index_commercial_document_on_amounts" }
  end
end
