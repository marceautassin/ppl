class ChangeTypeSSnumberInUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :social_security_number, :string
  end
end
