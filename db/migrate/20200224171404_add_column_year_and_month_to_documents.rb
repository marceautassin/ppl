class AddColumnYearAndMonthToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :year, :integer
    add_column :documents, :month, :integer
  end
end
