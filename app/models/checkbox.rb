# frozen_string_literal: true

class Checkbox < ApplicationRecord
  belongs_to :question
  has_many :checkbox_options

  validates :subject, presence: true
end
