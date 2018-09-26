# frozen_string_literal: true

class Survey < ApplicationRecord
  belongs_to :company
  has_many :questions
  has_many :answers

  validates :title, presence: true
end
