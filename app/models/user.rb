require 'digest'

class User < ApplicationRecord

	before_create :encrypt_password
	has_many :tasks, dependent: :destroy
	
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/}
	validates :password, presence: true, length: { in: 6..15 }

	enum :role, %i[admin viewer], default: :viewer

	private
	
	def encrypt_password
		salted_password = "xyz#{self.password.reverse}taskmanagement"
    self.password = Digest::SHA1.hexdigest(salted_password)
	end
end

