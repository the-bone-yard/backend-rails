class User < ApplicationRecord
  validates_presence_of :email, :password, :api_key
  validates_uniqueness_of :email
  has_secure_password
end
