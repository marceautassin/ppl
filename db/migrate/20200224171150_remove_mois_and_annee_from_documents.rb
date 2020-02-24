class RemoveMoisAndAnneeFromDocuments < ActiveRecord::Migration[5.2]
  def change
    remove_column :documents, :mois
    remove_column :documents, :année
  end
end
