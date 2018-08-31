# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.references :question, foreign_key: true
      t.references :user, foreign_key: true
      t.references :answer, foreign_key: true

      t.timestamps
    end
  end
end
