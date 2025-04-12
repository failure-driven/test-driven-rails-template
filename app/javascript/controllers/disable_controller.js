import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button"];

  connect() {
    this.element.dataset["action"] = "click->disable#disableButton";
  }

  disableButton() {
    this.buttonTarget.disabled = true;
    this.buttonTarget.innerHTML = this.buttonTarget.dataset.disableWith;
  }
}
