import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["source", "button"];

  async copy() {
    await navigator.clipboard.writeText(this.sourceTarget.value);

    const original = this.buttonTarget.innerHTML;

    this.buttonTarget.textContent =
      this.buttonTarget.dataset.clipboardCopiedLabel;

    setTimeout(() => {
      this.buttonTarget.innerHTML = original;
    }, 1500);
  }
}
