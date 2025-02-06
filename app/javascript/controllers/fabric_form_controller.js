import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="fabric-form"
export default class extends Controller {
  static targets = ["image", "fabricType", "fabricTypeInput", "quantity", "quantityInput", "uploadButton", "fileInput"]

  previewImage(event) {
    const input = event.target;
    if (input.files && input.files[0]) {
      const reader = new FileReader();
      reader.onload = (e) => {
        this.imageTarget.src = e.target.result;
      };
      reader.readAsDataURL(input.files[0]);

      this.showUploadButton();
    }
  }

  updateField(event) {
    const target = event.target;
    if (target.id === "fabric-type-input") {
      this.fabricTypeTarget.textContent = target.value || "FABRIC TYPE";
    } else if (target.id === "fabric-length-input") {
      this.quantityTarget.textContent = target.value || "...";
    }
  }

  showUploadButton() {
    this.uploadButtonTarget.classList.remove("d-none"); // Reveal the button
  }
}
