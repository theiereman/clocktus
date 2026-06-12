# frozen_string_literal: true

class NavbarEntryComponent < ViewComponent::Base
  def initialize(path:, icon:)
    @path = path
    @icon = icon
  end

  private

  def active?
    Current.path == @path
  end
end
