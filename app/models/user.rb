# frozen_string_literal: true

class User < ApplicationRecord
  # has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  has_secure_password

  enum :role, %i[admin viewer], default: :viewer

end
