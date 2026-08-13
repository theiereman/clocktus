import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.style.transition = "transform 200ms cubic-bezier(0.34, 1.56, 0.64, 1), filter 200ms cubic-bezier(0.34, 1.56, 0.64, 1), box-shadow 150ms ease, border-color 150ms ease"
  }

  press() {
    this.element.style.transform = "scale(0.95)"
    this.element.style.filter = "brightness(0.75)"
  }

  release() {
    this.element.style.transform = ""
    this.element.style.filter = ""
  }
}
