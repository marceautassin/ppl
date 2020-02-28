class AddDefaultToCategoryAndAmount < ActiveRecord::Migration[5.2]
  def change
    change_column_default :doc_lines, :category, ""
    change_column_default :doc_lines, :amount, 0
  end
end
