# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Park, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :formatted_address }
    it { should validate_presence_of :opening_hours }
    it { should validate_presence_of :photo }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :email }
    it { should validate_presence_of :lat }
    it { should validate_presence_of :lng }
  end

  describe 'relationships' do
    it { should belong_to :user }
  end
end
