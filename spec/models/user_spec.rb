require 'rails_helper'

RSpec.describe User, type: :model do
  let(:company) { FactoryBot.create(:company) }
  it 'is valid with a email, name, password and password' do
    user = FactoryBot.build(:user, company_id: company.id)
    expect(user).to be_valid
  end

  it 'is invalid with a duplicate email address' do
    user1 = User.create(email: 'a@a', name: 'hoge1', password: 'aaaaaa', company_id: company.id)
    user2 = User.new(email: 'a@a', name: 'hoge2', password: 'bbbbbb', company_id: company.id)
    expect(user2.id).to eq nil
  end
end
