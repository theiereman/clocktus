import { Controller } from "@hotwired/stimulus";

const DIMMED_OPACITY = 0.15;
const LEGEND_ITEM_PADDING = 6;
const LEAVE_DELAY_MS = 120;
const HIDDEN_ROW_CLASSES = [ "opacity-40", "line-through" ];

export default class extends Controller {
  static targets = [ "row" ];
  static values = { resizeOnHide: { type: Boolean, default: false } };

  connect() {
    this.waitForChart();
  }

  disconnect() {
    if (this.retryFrame) cancelAnimationFrame(this.retryFrame);
    clearTimeout(this.leaveTimer);
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
    this.chartObject = chart.getChartObject();
    const legend = this.chartObject.options.plugins.legend;

    this.originalStyles = this.chartObject.data.datasets.map((dataset) => ({
      borderColor: dataset.borderColor,
      backgroundColor: dataset.backgroundColor,
      pointBackgroundColor: dataset.pointBackgroundColor,
      pointHoverBackgroundColor: dataset.pointHoverBackgroundColor,
    }));
    this.originalLabels = [...this.chartObject.data.labels];
    this.originalDatasets = this.chartObject.data.datasets.map((dataset) => [...dataset.data]);
    this.hiddenIndices = new Set();

    // tighten the gap between legend items so crossing it doesn't briefly leave every item
    legend.labels = { ...legend.labels, padding: LEGEND_ITEM_PADDING };

    legend.onHover = (_event, legendItem) => {
      clearTimeout(this.leaveTimer);
      this.dim(legendItem.datasetIndex);
    };
    // delay the undim so hopping from one item straight to the next doesn't flash everything back on
    legend.onLeave = () => {
      this.leaveTimer = setTimeout(() => this.undim(), LEAVE_DELAY_MS);
    };
    legend.onClick = (_event, legendItem) => this.toggle(legendItem.datasetIndex);
  }

  rowHover({ params: { index } }) {
    clearTimeout(this.leaveTimer);
    this.dim(index);
  }

  rowLeave() {
    this.leaveTimer = setTimeout(() => this.undim(), LEAVE_DELAY_MS);
  }

  rowClick({ params: { index } }) {
    this.toggle(index);
  }

  toggle(index) {
    clearTimeout(this.leaveTimer);
    this.hiddenIndices.has(index) ? this.hiddenIndices.delete(index) : this.hiddenIndices.add(index);
    this.chartObject.getDatasetMeta(index).hidden = this.hiddenIndices.has(index);

    // clears any dim left over from hovering the item we just clicked
    this.resetColors();
    this.syncRowStates();

    if (this.resizeOnHideValue) {
      this.chartObject.data.labels = this.originalLabels.filter((_, i) => !this.hiddenIndices.has(i));
      this.chartObject.data.datasets.forEach((dataset, datasetIndex) => {
        dataset.data = this.originalDatasets[datasetIndex].filter((_, i) => !this.hiddenIndices.has(i));
      });
    }

    this.chartObject.update();
  }

  dim(hoveredIndex) {
    if (this.chartObject.getDatasetMeta(hoveredIndex).hidden) return;

    this.chartObject.data.datasets.forEach((dataset, index) => {
      if (this.chartObject.getDatasetMeta(index).hidden) return;

      const original = this.originalStyles[index];

      if (index === hoveredIndex) {
        Object.assign(dataset, original);
        return;
      }

      Object.entries(original).forEach(([ key, value ]) => {
        if (value) dataset[key] = this.withAlpha(value, DIMMED_OPACITY);
      });
    });
    this.chartObject.update();
  }

  undim() {
    this.resetColors();
    this.chartObject.update();
  }

  resetColors() {
    this.chartObject.data.datasets.forEach((dataset, index) => {
      if (this.chartObject.getDatasetMeta(index).hidden) return;
      Object.assign(dataset, this.originalStyles[index]);
    });
  }

  syncRowStates() {
    this.rowTargets.forEach((row) => {
      const hidden = this.hiddenIndices.has(Number(row.dataset.chartLegendIndexParam));
      HIDDEN_ROW_CLASSES.forEach((className) => row.classList.toggle(className, hidden));
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
