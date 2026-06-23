module NavigationHelper
  def navigation_items
    [
      { path: root_path, icon: "layout-dashboard", additional_path: activities_path },
      { path: calendar_path, icon: "calendar" },
      { path: statistics_path, icon: "chart-column-big" },
      { path: settings_path, icon: "settings" }
    ]
  end
end
