# frozen_string_literal: true

class AnswerRadiobuttonOption < ApplicationRecord
  belongs_to :answer
  belongs_to :radiobutton_option
end
