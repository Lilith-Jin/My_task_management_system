# frozen_string_literal: true

module TasksHelper

  def human_attribute_states
    Hash[Task.states.map { |k,v| [k, Task.human_attribute_name("state.#{k}")] }]
  end
end
