# Pin npm packages by running ./bin/importmap

pin "application"
pin "view_transitions"
pin "turbo_helpers"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "chartkick", to: "chartkick.js"
pin "Chart.bundle", to: "Chart.bundle.js"
pin "@plausible-analytics/tracker", to: "@plausible-analytics--tracker.js" # @0.4.5
pin "@rolemodel/turbo-confirm", to: "@rolemodel--turbo-confirm.js" # @2.2.3
pin "@floating-ui/dom", to: "@floating-ui--dom.js" # @1.8.0
pin "@floating-ui/core", to: "@floating-ui--core.js" # @1.8.0
pin "@floating-ui/utils", to: "@floating-ui--utils.js" # @0.2.12
pin "@floating-ui/utils/dom", to: "@floating-ui--utils--dom.js" # @0.2.12
