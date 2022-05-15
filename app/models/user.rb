# frozen_string_literal: true

class User < ApplicationRecord
  # has_many :tasks, dependent: :destroy
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  has_many :tasks, dependent: :destroy
  enum :role, %i[admin viewer], default: :viewer
end
