class AddSiretToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :siret, :string
  end
end
