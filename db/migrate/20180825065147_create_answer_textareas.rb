# frozen_string_literal: true

class CreateAnswerTextareas < ActiveRecord::Migration[5.2]
  def change
    create_table :answer_textareas do |t|
      t.string :content
      t.references :answer, foreign_key: true
      t.references :textarea, foreign_key: true

      t.timestamps
    end
  end
end
