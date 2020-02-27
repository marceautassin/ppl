class ChangeTypeToDocline < ActiveRecord::Migration[5.2]
  def change
    rename_column :doc_lines, :type, :category
  end
end
