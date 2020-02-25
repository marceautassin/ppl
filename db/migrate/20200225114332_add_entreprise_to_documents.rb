class AddEntrepriseToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :entreprise, :string
  end
end
