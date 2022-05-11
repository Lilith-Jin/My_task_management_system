# frozen_string_literal: true

module TasksHelper
  def state_menu_search(states)
    states.map do |key, value|
      [I18n.t(key, scope: %i[task state]), value]
    end
  end

  def state_menu(states)
    states.map do |key|
      [I18n.t(key, scope: %i[task state]), key]
    end
  end

  def priority_menu(priorities)
    priorities.map do |key|
      [I18n.t(key, scope: %i[task priority]), key]
    end
  end
end
