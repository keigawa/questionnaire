class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :picture, :binary
    add_column :users, :president, :boolean, default: false, null: false
    add_reference :users, :company, foreign_key: true
  end
end
