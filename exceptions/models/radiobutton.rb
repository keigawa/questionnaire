# frozen_string_literal: true

class Radiobutton < ApplicationRecord
  belongs_to :question
  has_many :radiobutton_options
end
