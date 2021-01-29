# frozen_string_literal: true

class User < ApplicationRecord
  validates_presence_of :email, :password, :api_key
  validates_uniqueness_of :email
  before_validation :set_api_key
  has_secure_password

  def self.new_user(data)
    if check_key(data[:api_key])
      User.create!({email: data[:email], password: data[:password]})
    end
  end

  private

  def self.check_key(key)
    key == ENV['API']
  end

  def set_api_key
    self.api_key = ApiKey.generator
  end
end
