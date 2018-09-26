# frozen_string_literal: true

class CheckboxOption < ApplicationRecord
  belongs_to :checkbox

  validates :optionname, presence: true
end
