# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.integer :display_order, unique: true
      t.references :survey, foreign_key: true

      t.timestamps
    end
  end
end
