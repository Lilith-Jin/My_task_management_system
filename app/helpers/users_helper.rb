module UsersHelper
	def role_menu(roles)
		roles.map do |key|
			[I18n.t(key, scope: %i[user role]), key]
		end
	end
end
