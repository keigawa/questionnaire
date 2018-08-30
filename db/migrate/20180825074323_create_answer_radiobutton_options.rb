# frozen_string_literal: true

class CreateAnswerRadiobuttonOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :answer_radiobutton_options do |t|
      t.string :check
      t.references :answer, foreign_key: true
      t.references :radiobutton_option, foreign_key: true

      t.timestamps
    end
  end
end
