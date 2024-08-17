import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["select"];

  updateUrlWithParams(event) {
    if (event) {
      event.preventDefault();
    }

    const params = new URLSearchParams(window.location.search);
    const selectedFilter = event ? event.target.name : null;

    this.selectTargets.forEach((select) => {
      if (select.name === selectedFilter) {
        const value = select.value;
        if (value) {
          params.set(select.name, value);
        } else {
          params.delete(select.name);
        }
      } else {
        select.value = "";
        params.delete(select.name);
      }
    });

    window.history.replaceState(
      {},
      "",
      `${window.location.pathname}?${params.toString()}`
    );
  }

  clearFilters(event) {
    event.preventDefault();

    const params = new URLSearchParams(window.location.search);
    this.selectTargets.forEach((select) => {
      select.value = "";
      params.delete(select.name);
    });

    Turbo.visit(window.location.pathname, { action: "replace" });
  }
}
