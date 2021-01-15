require 'rails_helper'

RSpec.describe Coordinates, type: :model do
  describe 'validations' do
    it { should validate_presence_of :city }
    it { should validate_presence_of :area }
    it { should validate_presence_of :lat }
    it { should validate_presence_of :lng }
  end
end
