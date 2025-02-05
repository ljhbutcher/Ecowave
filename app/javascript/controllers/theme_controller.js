import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["icon"];

  connect() {
    if (localStorage.getItem("theme") === "dark") {
      this.applyDarkMode();
    }
  }

  toggle() {
    if (document.body.classList.contains("dark-mode")) {
      this.applyLightMode();
    } else {
      this.applyDarkMode();
    }
  }

  applyDarkMode() {
    document.body.classList.add("dark-mode");
    this.iconTarget.src = "/assets/night.png"; // Switch to night icon
    localStorage.setItem("theme", "dark");
  }

  applyLightMode() {
    document.body.classList.remove("dark-mode");
    this.iconTarget.src = "/assets/day.png"; // Switch back to day icon
    localStorage.setItem("theme", "light");
  }
}
