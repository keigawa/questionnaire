class CreateCheckboxOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :checkbox_options do |t|
      t.string :optionname
      t.references :checkbox, foreign_key: true

      t.timestamps
    end
  end
end
