FactoryBot.define do
  factory :user do
    email { 'MyString@MyString' }
    name { 'John' }
    password { '111111' }
    president { 'false' }
  end
end
