# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @tasks = Task.includes(:use)
  end
end
