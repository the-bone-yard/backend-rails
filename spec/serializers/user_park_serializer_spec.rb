require 'rails_helper'

describe 'UserParkSerializer' do
  it 'creates a JSON object with specific attributes' do
    user = User.create!({email: '1234@email.com', password: '1111'})
    3.times do
      Park.create!({name: 'The Park', formatted_address: '1222 Not an Address', opening_hours: 'never', photo: 'no photo for you', rating: 'all of them', email: '222@email.com', lat: '1222.44', lng: '-5506.22', user_id: user.id})
    end
    result = UserParkSerializer.to_hash(Park.all)
    park_keys = %w(name email formatted_address opening_hours photo rating lat lng)

    expect(result).to be_a(Hash)
    expect(result.keys).to eq(%w(parks))
    expect(result['parks'].length).to eq(3)
    result['parks'].each do |park|
      park_keys.each do |keyword|
        expect(park.keys.include?(keyword)).to eq(true)
      end
    end
  end
end
