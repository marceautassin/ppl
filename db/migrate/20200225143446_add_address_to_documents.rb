class AddAddressToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :address, :string
  end
end
