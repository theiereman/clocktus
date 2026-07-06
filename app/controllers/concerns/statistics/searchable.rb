module Statistics::Searchable
  extend ActiveSupport::Concern

  def filtered_activities(user)
    @activities = user.activities.where("started_at < ?", Date.current)
    @activities = @activities.year(params[:year]) if params[:year].present?
    @activities
  end
end
