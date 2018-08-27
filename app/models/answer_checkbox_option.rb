class AnswerCheckboxOption < ApplicationRecord
  belongs_to :answer
  belongs_to :checkbox_option
end
