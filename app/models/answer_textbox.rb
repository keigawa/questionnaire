# frozen_string_literal: true

class AnswerTextbox < ApplicationRecord
  belongs_to :answer
  belongs_to :textbox

  validates :content, presence: true
end
