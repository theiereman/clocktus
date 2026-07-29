import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.waitForChart();
  }

  disconnect() {
    if (this.retryFrame) cancelAnimationFrame(this.retryFrame);
  }

  waitForChart() {
    const chartElement = this.element.querySelector("[id]");
    const chart = chartElement && window.Chartkick?.charts[chartElement.id];

    if (chart) {
      this.setup(chart);
    } else {
      this.retryFrame = requestAnimationFrame(() => this.waitForChart());
    }
  }

  setup(chart) {
    const chartObject = chart.getChartObject();
    const originalLabels = [...chartObject.data.labels];
    const originalDatasets = chartObject.data.datasets.map((dataset) => [...dataset.data]);
    const hiddenIndices = new Set();

    chartObject.options.plugins.legend.onClick = (_event, legendItem) => {
      const index = legendItem.datasetIndex;

      hiddenIndices.has(index) ? hiddenIndices.delete(index) : hiddenIndices.add(index);
      chartObject.getDatasetMeta(index).hidden = hiddenIndices.has(index);

      chartObject.data.labels = originalLabels.filter((_, i) => !hiddenIndices.has(i));
      chartObject.data.datasets.forEach((dataset, datasetIndex) => {
        dataset.data = originalDatasets[datasetIndex].filter((_, i) => !hiddenIndices.has(i));
      });

      chartObject.update();
    };
  }
}
