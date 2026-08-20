import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { labels: Array };

  connect() {
    this.waitForChart();
  }

  disconnect() {
    if (this.retryFrame) cancelAnimationFrame(this.retryFrame);
  }

  waitForChart() {
    const chartElement = this.element.querySelector("[id]");
    const chart = chartElement && window.Chartkick?.charts[chartElement.id];

    if (chart && chart.getElement() === chartElement) {
      this.setup(chart.getChartObject());
    } else {
      this.retryFrame = requestAnimationFrame(() => this.waitForChart());
    }
  }

  setup(chartObject) {
    const labelFor = (value) => this.labelsValue[value] ?? value;

    chartObject.options.scales.y.ticks = {
      ...chartObject.options.scales.y.ticks,
      stepSize: 1,
      callback: labelFor,
    };
    chartObject.options.plugins.tooltip = {
      ...chartObject.options.plugins.tooltip,
      callbacks: {
        ...chartObject.options.plugins.tooltip?.callbacks,
        label: (context) => labelFor(context.parsed.y),
      },
    };
    chartObject.update();
  }
}
