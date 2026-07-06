module NavigationHelper
  def navigation_items
    [
      { path: activities_path, icon: "layout-dashboard", nav_index: 0 },
      { path: calendar_path, icon: "calendar", nav_index: 1 },
      { path: statistics_path, icon: "chart-column-big", nav_index: 2 },
      { path: settings_path, icon: "settings", nav_index: 3 }
    ]
  end

  def current_nav_index
    navigation_items.find_index { |item| item[:path] == Current.path }
  end
end
