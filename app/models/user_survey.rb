# frozen_string_literal: true

class UserSurvey < ApplicationRecord
  belongs_to :user
  belongs_to :survey
end
