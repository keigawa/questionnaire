class HomeUsersController < ApplicationUsersController
  def display
    @surveys = Survey.where(complete_flag: true).where(company_id: current_user.company_id)
    @company = Company.find(current_user.company_id)
  end
end
