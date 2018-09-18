FactoryBot.define do
  factory :survey do
    title { 'SurveyTitle' }
    complete_flag { 'false' }
    company_id { '1' }
  end
end
