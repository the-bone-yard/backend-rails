# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end

  describe 'relationships' do
    it { should have_many :parks }
  end

  describe 'api_key' do
    it 'api_key is generated and assigned upon creation' do
      user = User.create!(email: 'hello@email.com', password: 'yep')

      expect(user.api_key).to_not be_nil
      expect(user.api_key).to be_a(String)
      expect(user.api_key.length).to eq(24)
    end
  end
end

RSpec.describe User, type: :model do
  describe '.new_user(data)' do
    it 'can check the api key' do
      expect(User.all.count).to eq(0)
      data = {
        api_key: '2gymzMNPQSJqrkExBLz9Mgtt',
        email: '1222@email.com',
        password: '222'
      }
      User.new_user(data)
      expect(User.all.count).to eq(1)
    end
  end
end

RSpec.describe User, type: :model do
  describe '.check_credentials()' do
    it 'can check credentials are correct (with correct info)' do
      User.create!({ email: '444@email.com', password: 'tttt' })
      body = {
        email: '444@email.com',
        password: 'tttt'
      }
      result = User.check_credentials(body)
      expect(result).to eq(User.last)
    end
    it 'can send back error message with incorrect info' do
      User.create!({ email: '444@email.com', password: 'tttt' })
      body = {
        email: '444@email.com',
        password: '2222s'
      }
      result = User.check_credentials(body)
      expect(result).to eq('CREDENTIALS INCORRECT')
    end
  end
end
