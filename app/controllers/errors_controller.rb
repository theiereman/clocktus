class ErrorsController < ApplicationController
  layout false

  allow_unauthenticated_access

  VALID_STATUS_CODES = %w[400 404 406 422 429 500].freeze
  def show
    status_code = VALID_STATUS_CODES.include?(params[:code]) ? params[:code] : 500
    @message = get_error_message(status_code)
    respond_to do |format|
      format.html { render status: status_code }
      format.any { head status_code }
    end
  end

  private

  def get_error_message(code)
    case code.to_i
    when 400
      "Invalid request"
    when 404
      "Not found"
    when 406
      "Browser unsupported"
    when 500
      "Internal server error"
    else
      "Unexpected error"
    end
  end
end
