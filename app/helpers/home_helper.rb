module HomeHelper
  def hero_mockup_slots
    [
      { time: "06:00", color: "#2d3966", label: t("activity.category.defaults.sleep") },
      { time: "07:00", color: "#8ff0a4", label: t("activity.category.defaults.reading") },
      { time: "08:00", color: "#dc8add", label: t("activity.category.defaults.work") },
      { time: "09:00", color: "#dc8add", label: t("activity.category.defaults.work") },
      { time: "10:00", color: "#f66151", label: t("activity.category.defaults.cooking") },
      { time: "11:00", color: "#f6d32d", label: t("activity.category.defaults.leisure") },
      { time: "12:00", color: "#99c1f1", label: t("activity.category.defaults.outings") },
      { time: "13:00", color: "#dc8add", label: t("activity.category.defaults.work") }
    ]
  end

  def stats_mockup_categories
    [
      { label: t("activity.category.defaults.sleep"), color: "#6b7280", height: 85, percentage: 34, hours: 122 },
      { label: t("activity.category.defaults.work"), color: "#dc8add", height: 65, percentage: 27, hours: 108 },
      { label: t("activity.category.defaults.leisure"), color: "#f6d32d", height: 40, percentage: 15, hours: 67 },
      { label: t("activity.category.defaults.reading"), color: "#8ff0a4", height: 25, percentage: 9, hours: 24 },
      { label: t("activity.category.defaults.outings"), color: "#99c1f1", height: 20, percentage: 8, hours: 18 },
      { label: t("activity.category.defaults.cooking"), color: "#f66151", height: 15, percentage: 7, hours: 12 }
    ]
  end

  def how_it_works_steps
    [
      { icon: "layout-grid", title: t("home.how_it_works.step1_title"), text: t("home.how_it_works.step1_text") },
      { icon: "tags", title: t("home.how_it_works.step2_title"), text: t("home.how_it_works.step2_text") },
      { icon: "chart-column-big", title: t("home.how_it_works.step3_title"), text: t("home.how_it_works.step3_text") }
    ]
  end

  def privacy_points
    [
      { icon: "git-pull-request-arrow", title: t("home.privacy.open_source_title"), text: t("home.privacy.open_source_text") },
      { icon: "shield-check", title: t("home.privacy.no_ads_title"), text: t("home.privacy.no_ads_text") },
      { icon: "cookie", title: t("home.privacy.analytics_title"), text: t("home.privacy.analytics_text") },
      { icon: "brush-cleaning", title: t("home.privacy.data_removal_title"), text: t("home.privacy.data_removal_text") }
    ]
  end
end
