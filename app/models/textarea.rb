# frozen_string_literal: true

class Textarea < ApplicationRecord
  belongs_to :question

  validates :subject, presence: true
end
