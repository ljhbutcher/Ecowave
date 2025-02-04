// app/javascript/controllers/fabric_form_controller.js
import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="fabric-form"
export default class extends Controller {
  static targets = ["image", "fabricType", "fabricTypeInput", "quantity", "quantityInput"]

  previewImage(event) {
    const input = event.target;
    if (input.files && input.files[0]) {
      const reader = new FileReader();
      reader.onload = (e) => {
        // Update the image preview source with the selected file
        this.imageTarget.src = e.target.result;
      };
      reader.readAsDataURL(input.files[0]);
    }
  }

  updateField(event) {
    const target = event.target;
    // Update fabric type if the fabric-type input is changed
    if (target.id === "fabric-type-input") {
      this.fabricTypeTarget.textContent = target.value || "FABRIC TYPE";
    }
    // Update quantity if the fabric-length input is changed
    else if (target.id === "fabric-length-input") {
      this.quantityTarget.textContent = target.value || "...";
    }
  }
}
