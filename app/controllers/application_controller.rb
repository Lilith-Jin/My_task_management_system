# frozen_string_literal: true

class ApplicationController < ActionController::Base
    def login(user)
		session[:session]=user.id
	end
end
