class Current < ActiveSupport::CurrentAttributes
  attribute :session, :controller, :action, :path
  delegate :user, to: :session, allow_nil: true
end
