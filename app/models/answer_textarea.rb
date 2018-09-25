# frozen_string_literal: true

class AnswerTextarea < ApplicationRecord
  belongs_to :answer
  belongs_to :textarea

  validates :content, presence: true
end
