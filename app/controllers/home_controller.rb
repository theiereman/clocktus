class HomeController < ApplicationController
  allow_unauthenticated_access only: :show
  layout "landing"

  def show
    redirect_to activities_path if authenticated?
  end
end
