# frozen_string_literal: true

class User < ApplicationRecord
  validates_presence_of :email, :password, :api_key
  validates_uniqueness_of :email
  has_many :parks
  before_validation :set_api_key
  has_secure_password

  def self.new_user(data)
    User.create!({ email: data[:email], password: data[:password] }) if check_key(data[:api_key])
  end

  def self.check_key(key)
    key == ENV['API']
  end

  def self.check_credentials(data)
    user = User.find_by(email: data[:email])
    if user.nil? || !user.authenticate(data[:password])
      'CREDENTIALS INCORRECT'
    else
      user
    end
  end

  private

  def set_api_key
    self.api_key = ApiKey.generator
  end
end
