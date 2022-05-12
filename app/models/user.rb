class User < ApplicationRecord
	has_many :tasks, dependent: :destroy
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/}
	validates :password, presence: true, length: { in: 6..15 }
	enum :role, %i[admin viewer], default: :viewer
end

