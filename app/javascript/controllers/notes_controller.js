import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["text", "form", "textarea"];

  connect() {
    this.resetForm(); // Ensures correct visibility on page load
  }

  edit() {
    this.textTarget.style.display = "none";
    this.formTarget.style.display = "block";
    this.textareaTarget.focus();
  }

  cancel() {
    this.resetForm();
  }

  async save(event) {
    event.preventDefault(); // Prevents default form submission

    const form = this.formTarget;
    const formData = new FormData(form);

    try {
      const response = await fetch(form.action, {
        method: "PATCH",
        body: formData,
        headers: {
          "X-Requested-With": "XMLHttpRequest",
          "Accept": "application/json",
        },
      });

      if (response.ok) {
        const data = await response.json();
        this.textTarget.innerHTML = data.notes; // Update notes text
        this.resetForm();
      } else {
        console.error("Failed to update notes");
      }
    } catch (error) {
      console.error("Error:", error);
    }
  }

  resetForm() {
    this.textTarget.style.display = "block";
    this.formTarget.style.display = "none";
  }
}
