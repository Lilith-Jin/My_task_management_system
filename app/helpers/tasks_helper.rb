# frozen_string_literal: true

module TasksHelper
  def task_state_options(states)
    states.map do |key, value|
      [I18n.t(key, scope: [:task, :state]), value]
    end
  end
end
