# frozen_string_literal: true

class Textbox < ApplicationRecord
  belongs_to :question

  validates :subject, presence: true
end
