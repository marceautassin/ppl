class CreateDocLines < ActiveRecord::Migration[5.2]
  def change
    create_table :doc_lines do |t|
      t.integer :type
      t.float :amount
      t.references :documents, foreign_key: true

      t.timestamps
    end
  end
end
