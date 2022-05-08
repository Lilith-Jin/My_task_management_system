# frozen_string_literal: true

class Task < ApplicationRecord
  enum :priority, %i[high mid low], default: :high
  enum :state, %i[waiting running done], default: :waiting
end
