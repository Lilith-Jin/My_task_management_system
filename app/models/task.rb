# frozen_string_literal: true

class Task < ApplicationRecord
  enum :priority, %i[high mid low], default: :high
  enum :status, %i[waiting running done], default: :waiting
end
