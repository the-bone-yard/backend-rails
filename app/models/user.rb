class User < ApplicationRecord
  validates_presence_of :email, :password, :api_key
  validates_uniqueness_of :email
  before_validation :set_api_key
  has_secure_password

  private

  def set_api_key
    self.api_key = ApiKey.generator
  end
end
