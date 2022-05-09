# frozen_string_literal: true

class Task < ApplicationRecord
  enum :priority, %i[high mid low], default: :high
  enum :state, %i[waiting running done], default: :waiting
  # enum state: {waiting:0, running:1, done:2}, default: :waiting
end
