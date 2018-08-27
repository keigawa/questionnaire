class CreateRadiobuttonOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :radiobutton_options do |t|
      t.string :optionname
      t.references :radiobutton, foreign_key: true

      t.timestamps
    end
  end
end
