require 'securerandom'

class User < ApplicationRecord
  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, require: true
  validates :api_key, uniqueness: true, presence: true
  has_secure_password

  after_validation(on: :create) do
    self.api_key = SecureRandom.hex(24)
  end

end
