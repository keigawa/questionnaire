# frozen_string_literal: true

class CreateSurveys < ActiveRecord::Migration[5.2]
  def change
    create_table :surveys do |t|
      t.string :title
      t.boolean :complete_flag, default: false, null: false
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
