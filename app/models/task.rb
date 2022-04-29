class Task < ApplicationRecord
    enum :priority, [:high, :mid, :low] , default: :high
    enum :status, [:waiting, :running, :done], default: :waiting
end
