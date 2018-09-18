require 'rails_helper'

RSpec.describe User, type: :model do
  let(:company) { FactoryBot.create(:company) }
  it 'is valid with a email, name, password and password' do
    user = FactoryBot.build(:user, company_id: company.id)
    expect(user).to be_valid
  end

  it 'is invalid with a duplicate email address' do
    user = User.create(email: 'a@a', name: 'hoge1', password: 'aaaaaa', company_id: company.id)
    expect{User.create!(email: 'a@a', name: 'hoge2', password: 'bbbbbb', company_id: company.id)}.to raise_error(ActiveRecord::RecordInvalid)
  end
end
