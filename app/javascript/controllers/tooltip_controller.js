import { Controller } from "@hotwired/stimulus";
import { computePosition, offset, flip, shift, arrow, autoUpdate } from "@floating-ui/dom";

// Connects to data-controller="tooltip"

const ARROW_STATIC_SIDE = { top: "bottom", right: "left", bottom: "top", left: "right" };

export default class extends Controller {
  static targets = ["text"];

  show(event) {
    const trigger = event.currentTarget;
    const tip = this.#textTargetFor(trigger);
    if (!tip) return;

    const arrowEl = this.#arrowFor(tip);

    tip.style.position = "fixed";
    tip.style.transform = "none";
    tip.classList.add("tooltiptext--visible");

    this.cleanup?.();
    this.cleanup = autoUpdate(trigger, tip, () =>
      computePosition(trigger, tip, {
        strategy: "fixed",
        placement: "bottom",
        middleware: [offset(6), flip(), shift({ padding: 8 }), arrow({ element: arrowEl })],
      }).then(({ x, y, placement, middlewareData }) => {
        tip.style.left = `${x}px`;
        tip.style.top = `${y}px`;

        const { x: arrowX, y: arrowY } = middlewareData.arrow;
        Object.assign(arrowEl.style, {
          left: arrowX != null ? `${arrowX}px` : "",
          top: arrowY != null ? `${arrowY}px` : "",
          [ARROW_STATIC_SIDE[placement.split("-")[0]]]: "-4px",
        });
      }),
    );
  }

  hide(event) {
    if (event.relatedTarget && event.currentTarget.contains(event.relatedTarget)) return;
    const tip = this.#textTargetFor(event.currentTarget);
    if (!tip) return;

    tip.classList.remove("tooltiptext--visible");
    tip.style.position = "";
    tip.style.left = "";
    tip.style.top = "";
    tip.style.transform = "";

    this.cleanup?.();
    this.cleanup = null;
  }

  disconnect() {
    this.cleanup?.();
  }

  #textTargetFor(trigger) {
    return this.textTargets.find((target) => trigger.contains(target));
  }

  #arrowFor(tip) {
    let arrowEl = tip.querySelector(".tooltip-arrow");
    if (!arrowEl) {
      arrowEl = document.createElement("div");
      arrowEl.className = "tooltip-arrow";
      tip.prepend(arrowEl);
    }
    return arrowEl;
  }
}
