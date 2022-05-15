# frozen_string_literal: true

module UsersHelper
  def option_for_role_select(roles)
    roles.map do |key|
      [I18n.t(key, scope: %i[user role]), key]
    end
  end
end
