import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["counter"];
  static values = { threshold: { type: Number, default: 0.3 } };

  connect() {
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
      return this.finish();
    }

    this.observer = new IntersectionObserver(
      ([entry]) => {
        if (!entry.isIntersecting) return;
        this.element.classList.add("is-visible");
        this.counterTargets.forEach((counter) => this.countUp(counter));
        this.observer.disconnect();
      },
      { threshold: this.thresholdValue },
    );
    this.observer.observe(this.element);
  }

  disconnect() {
    this.observer?.disconnect();
  }

  finish() {
    this.element.classList.add("is-visible");
    this.counterTargets.forEach((counter) => {
      counter.textContent = counter.dataset.countTo;
    });
  }

  countUp(counter) {
    const end = parseInt(counter.dataset.countTo, 10);
    const duration = 1200;
    const start = performance.now();

    const tick = (now) => {
      const progress = Math.min((now - start) / duration, 1);
      counter.textContent = Math.round(end * (1 - Math.pow(1 - progress, 3)));
      if (progress < 1) requestAnimationFrame(tick);
    };
    requestAnimationFrame(tick);
  }
}
