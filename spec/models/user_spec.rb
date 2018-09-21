require 'rails_helper'

RSpec.describe User, type: :model do
  let(:company) { create :company }
  let(:user) { build :user, company_id: company.id }
  let(:user1) { create :user, email: 'a@a', company_id: company.id }
  let(:user2) { create :user, email: 'a@a', company_id: company.id }

  it 'is valid with a email, name, password and password' do
    expect(user).to be_valid
  end

  it 'is invalid with a duplicate email address' do
    user1
    expect { user2 }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
