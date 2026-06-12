class ApplicationController < ActionController::Base
  include Authentication

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_action_and_controller_names

  private

  def set_action_and_controller_names
    Current.path = request.path
    Current.action = action_name
    Current.controller = controller_name
  end
end
