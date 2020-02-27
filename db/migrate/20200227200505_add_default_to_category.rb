class AddDefaultToCategory < ActiveRecord::Migration[5.2]
  def change
    change_column_default :doc_lines, :category, 0
  end
end
