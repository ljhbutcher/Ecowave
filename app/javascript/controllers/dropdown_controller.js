// app/javascript/controllers/dropdown_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    // Close the menu when clicking anywhere else on the document.
    this.boundClose = this.close.bind(this);
    document.addEventListener("click", this.boundClose);
  }

  disconnect() {
    document.removeEventListener("click", this.boundClose);
  }

  toggle(event) {
    event.stopPropagation();
    // Toggle "show" class on the menu.
    this.menuTarget.classList.toggle("show");
  }

  close(event) {
    // If the click is outside of this controller's element, close the menu.
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.remove("show");
    }
  }
}
