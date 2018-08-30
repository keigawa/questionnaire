# frozen_string_literal: true

class CreateTextareas < ActiveRecord::Migration[5.2]
  def change
    create_table :textareas do |t|
      t.string :subject
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
