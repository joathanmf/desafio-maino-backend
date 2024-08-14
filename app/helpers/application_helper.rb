# frozen_string_literal: true

module ApplicationHelper
  # Função que
  def active_link?(controllers:, actions:)
    current_controller = controller_name
    current_action = action_name
    controllers.include?(current_controller) && actions.include?(current_action)
  end
end
