class RenameDocumentRefence < ActiveRecord::Migration[5.2]
  def change
    remove_reference(:doc_lines, :documents, index: true, foreign_key: true)
    add_reference :doc_lines, :document, foreign_key: true
  end
end
