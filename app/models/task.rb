class Task < ApplicationRecord
    enum :priority, [:high, :medium, :low] , default: :high
    enum :status, [:waiting, :running, :done], default: :waiting
end
