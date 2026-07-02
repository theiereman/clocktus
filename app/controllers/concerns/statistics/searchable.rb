module Statistics::Searchable
  extend ActiveSupport::Concern

  def filtered_activities(user)
    @activities = user.activities
    @activities = @activities.year(params[:year]) if params[:year].present?
    @activities
  end
end
