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
    this.iconTarget.src = "/assets/night.png"; // Switch to night mode icon
    this.iconTarget.style.filter = "invert(100%) hue-rotate(180deg)"; // Apply inversion to the night icon
    localStorage.setItem("theme", "dark");
  }

  applyLightMode() {
    document.body.classList.remove("dark-mode");
    this.iconTarget.src = "/assets/day.png"; // Switch back to day mode icon
    this.iconTarget.style.filter = "none"; // Remove inversion effect
    localStorage.setItem("theme", "light");
  }
}
