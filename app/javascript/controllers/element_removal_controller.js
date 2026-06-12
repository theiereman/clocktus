import { Controller } from "@hotwired/stimulus"

// Removes its element from the DOM. Flash toasts wire this to their dismissal
// animation (animationend->element-removal#remove) so they clean themselves up
// once they've faded out — no JS timers needed. Mirrors basecamp/fizzy.
export default class extends Controller {
  remove() {
    this.element.remove()
  }
}
