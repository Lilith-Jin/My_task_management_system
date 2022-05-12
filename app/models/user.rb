class User < ApplicationRecord
	has_many :tasks, dependent: :destroy
	enum :role, %i[admin viewer], default: :viewer
end

