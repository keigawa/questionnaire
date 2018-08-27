class CreateAnswerTextboxes < ActiveRecord::Migration[5.2]
  def change
    create_table :answer_textboxes do |t|
      t.string :content
      t.references :answer, foreign_key: true
      t.references :textbox, foreign_key: true

      t.timestamps
    end
  end
end
