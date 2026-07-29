import { Controller } from "@hotwired/stimulus";

const DIMMED_OPACITY = 0.15;

export default class extends Controller {
  static values = { resizeOnHide: { type: Boolean, default: false } };

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
    const legend = chartObject.options.plugins.legend;

    this.originalStyles = chartObject.data.datasets.map((dataset) => ({
      borderColor: dataset.borderColor,
      backgroundColor: dataset.backgroundColor,
      pointBackgroundColor: dataset.pointBackgroundColor,
      pointHoverBackgroundColor: dataset.pointHoverBackgroundColor,
    }));
    this.originalLabels = [...chartObject.data.labels];
    this.originalDatasets = chartObject.data.datasets.map((dataset) => [...dataset.data]);
    this.hiddenIndices = new Set();

    legend.onHover = (_event, legendItem) => this.dim(chartObject, legendItem.datasetIndex);
    legend.onLeave = () => this.undim(chartObject);
    legend.onClick = (_event, legendItem) => this.toggle(chartObject, legendItem.datasetIndex);
  }

  toggle(chartObject, index) {
    this.hiddenIndices.has(index) ? this.hiddenIndices.delete(index) : this.hiddenIndices.add(index);
    chartObject.getDatasetMeta(index).hidden = this.hiddenIndices.has(index);

    // clears any dim left over from hovering the item we just clicked
    this.resetColors(chartObject);

    if (this.resizeOnHideValue) {
      chartObject.data.labels = this.originalLabels.filter((_, i) => !this.hiddenIndices.has(i));
      chartObject.data.datasets.forEach((dataset, datasetIndex) => {
        dataset.data = this.originalDatasets[datasetIndex].filter((_, i) => !this.hiddenIndices.has(i));
      });
    }

    chartObject.update();
  }

  dim(chartObject, hoveredIndex) {
    if (chartObject.getDatasetMeta(hoveredIndex).hidden) return;

    chartObject.data.datasets.forEach((dataset, index) => {
      if (chartObject.getDatasetMeta(index).hidden) return;

      const original = this.originalStyles[index];

      if (index === hoveredIndex) {
        Object.assign(dataset, original);
        return;
      }

      Object.entries(original).forEach(([ key, value ]) => {
        if (value) dataset[key] = this.withAlpha(value, DIMMED_OPACITY);
      });
    });
    chartObject.update();
  }

  undim(chartObject) {
    this.resetColors(chartObject);
    chartObject.update();
  }

  resetColors(chartObject) {
    chartObject.data.datasets.forEach((dataset, index) => {
      if (chartObject.getDatasetMeta(index).hidden) return;
      Object.assign(dataset, this.originalStyles[index]);
    });
  }

  withAlpha(color, alpha) {
    const hexMatch = /^#([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(color);
    if (hexMatch) {
      const [ , r, g, b ] = hexMatch;
      return `rgba(${parseInt(r, 16)}, ${parseInt(g, 16)}, ${parseInt(b, 16)}, ${alpha})`;
    }

    const rgbaMatch = /^rgba?\((\d+),\s*(\d+),\s*(\d+)/i.exec(color);
    if (rgbaMatch) {
      const [ , r, g, b ] = rgbaMatch;
      return `rgba(${r}, ${g}, ${b}, ${alpha})`;
    }

    return color;
  }
}
