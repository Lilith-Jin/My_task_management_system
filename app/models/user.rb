# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  has_many :tasks, dependent: :destroy
  enum :role, %i[admin viewer], default: :viewer
  before_destroy :destroy_admin

  private

  def destroy_admin
    return unless admin? && User.where(role: 'admin').count == 1
    errors.add(:role, message: '至少要存在一位管理員')
    throw(:abort)
  end
end
