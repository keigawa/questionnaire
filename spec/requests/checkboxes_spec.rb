require 'rails_helper'

RSpec.describe 'Checkboxes', type: :request do
  let(:company) { FactoryBot.create(:company) }
  let(:user) { FactoryBot.create(:user, company_id: company.id) }
  let(:survey) { FactoryBot.create(:survey, company_id: company.id) }
  let(:question) { FactoryBot.create(:question, survey_id: survey.id) }
  let(:checkbox) { FactoryBot.create(:checkbox, question_id: question.id) }

  before do
    login_user user
  end

  describe 'checkboxes#new' do
    it 'status200' do
      get new_survey_checkbox_path(survey.id)
      expect(response).to have_http_status(:ok)
    end
    it 'status404' do
      get new_survey_checkbox_path(1000)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'checkboxes#create' do
    it 'status200' do
      post survey_checkboxes_path(survey.id), params: { checkbox: FactoryBot.attributes_for(:checkbox)}
      expect(response).to have_http_status(:found)
    end
    it 'status404' do
      post survey_checkboxes_path(1000), params: { checkbox: FactoryBot.attributes_for(:checkbox)}
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'checkboxes#edit' do
    it 'status200' do
      get edit_survey_checkbox_path(survey.id, checkbox.id)
        expect(response).to have_http_status(:ok)
    end
    it 'status404' do
      get edit_survey_checkbox_path(survey.id, 1000)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'checkboxes#update' do
    it 'status200' do
      put survey_checkbox_path(survey.id, checkbox.id), params: { checkbox: FactoryBot.attributes_for(:checkbox)}
        expect(response).to have_http_status(:found)
    end
    it 'status404' do
      put survey_checkbox_path(survey.id, 1000), params: { checkbox: FactoryBot.attributes_for(:checkbox)}
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'checkboxes#destroy' do
    it 'status200' do
      delete survey_checkbox_path(survey.id, checkbox.id)
        expect(response).to have_http_status(:found)
    end
    it 'status404' do
      delete survey_checkbox_path(survey.id, 1000)
      expect(response).to have_http_status(:not_found)
    end
  end
end
