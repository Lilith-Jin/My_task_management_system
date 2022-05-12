class HomeController < ApplicationController
    def index
        @tasks = Task.includes(:use)
    end
end
