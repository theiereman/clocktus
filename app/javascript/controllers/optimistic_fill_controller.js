import { Controller } from "@hotwired/stimulus";

const HIGHLIGHT_CLASSES = ["border-3", "border-primary", "scale-105", "shadow-lg", "z-10"];
const RECONCILE_DELAY = 250;

// Connects to data-controller="optimistic-fill"
export default class extends Controller {
  static values = { slotSeconds: Number, cursor: Number, dayEnd: Number };

  connect() {
    this.highlightStart = this.cursorValue;
    this.offset = 0;
    this.pending = 0;
  }

  disconnect() {
    clearTimeout(this.reconcileTimer);
  }

  persist(event) {
    const submit = event.target.closest('input[type="submit"], button[type="submit"]');
    if (!submit) return;

    const form = submit.form;
    if (!form?.dataset.optimisticFillColor) return;

    event.preventDefault();

    const slotStart = this.highlightStart;
    if (slotStart > this.dayEndValue) return;

    const revert = this.paint(slotStart, form.dataset);
    const nextStart = slotStart + this.slotSecondsValue;
    this.moveHighlight(slotStart, nextStart);
    this.highlightStart = nextStart;

    this.send(form, this.offset, revert);
    this.offset += 1;
  }

  paint(slotStart, { optimisticFillColor, optimisticFillTextColor, optimisticFillLabel }) {
    const reverts = [];

    this.slotsAt(slotStart).forEach((slot) => {
      const previousStyle = slot.getAttribute("style");
      const wasMuted = slot.classList.contains("text-text/50");
      slot.style.backgroundColor = optimisticFillColor;
      slot.style.color = optimisticFillTextColor;
      slot.classList.remove("text-text/50");

      const label = slot.querySelector("[data-optimistic-label]");
      const wrapper = label?.parentElement;
      const previousLabel = label?.textContent;
      const wasItalic = wrapper?.classList.contains("italic");
      if (label) {
        label.textContent = optimisticFillLabel;
        wrapper.classList.remove("italic");
      }

      reverts.push(() => {
        previousStyle === null ? slot.removeAttribute("style") : slot.setAttribute("style", previousStyle);
        if (wasMuted) slot.classList.add("text-text/50");
        if (label) {
          label.textContent = previousLabel;
          if (wasItalic) wrapper.classList.add("italic");
        }
      });
    });

    return () => reverts.forEach((revert) => revert());
  }

  moveHighlight(from, to) {
    this.slotsAt(from).forEach((slot) => slot.classList.remove(...HIGHLIGHT_CLASSES));
    this.slotsAt(to).forEach((slot) => slot.classList.add(...HIGHLIGHT_CLASSES));
  }

  send(form, offset, revert) {
    const body = new FormData(form);
    body.set("slot_offset", offset);
    body.set("optimistic", "1");

    this.pending += 1;
    fetch(form.action, { method: "POST", body, headers: { Accept: "text/vnd.turbo-stream.html" } })
      .then((response) => {
        if (response.ok) return;
        revert();
        return response.text().then((html) => window.Turbo?.renderStreamMessage(html));
      })
      .catch(() => revert())
      .finally(() => {
        this.pending -= 1;
        this.scheduleReconcile();
      });
  }

  scheduleReconcile() {
    clearTimeout(this.reconcileTimer);
    this.reconcileTimer = setTimeout(() => this.reconcile(), RECONCILE_DELAY);
  }

  reconcile() {
    if (this.pending > 0) return this.scheduleReconcile();

    const frame = this.element.closest("turbo-frame");
    const form = this.element.querySelector("form");
    if (!frame || !form) return;

    frame.src = `${form.action}?datetime=${this.highlightStart}`;
  }

  slotsAt(timestamp) {
    const frame = this.element.closest("turbo-frame") || document;
    return frame.querySelectorAll(`[data-optimistic-slot-start="${timestamp}"]`);
  }
}
