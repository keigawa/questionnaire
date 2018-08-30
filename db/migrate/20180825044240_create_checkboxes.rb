# frozen_string_literal: true

class CreateCheckboxes < ActiveRecord::Migration[5.2]
  def change
    create_table :checkboxes do |t|
      t.string :subject
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
