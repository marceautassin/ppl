class AddDateToDocLines < ActiveRecord::Migration[5.2]
  def change
    add_column :doc_lines, :data_entry_period, :date
  end
end
