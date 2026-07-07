import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="transfer-activities"
export default class extends Controller {
  static targets = ["mode", "target"];

  connect() {
    this.toggle();
  }

  toggle() {
    const transferSelected =
      this.modeTargets.find((mode) => mode.checked)?.value === "transfer";
    this.targetTarget.disabled = !transferSelected;
  }
}
