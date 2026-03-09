import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [ 'goalSelect', 'walletSelect' ];

  connect() {
    this.toggleFields();
  }

  toggle() {
    this.toggleFields();
  }

  toggleFields() {
    const goalSelect = this.goalSelectTarget;
    const walletSelect = this.walletSelectTarget;

    if (goalSelect.value !== '') {
      walletSelect.tomselect.disable();
    } else {
      walletSelect.tomselect.enable();
    }

    if (walletSelect.value !== '') {
      goalSelect.tomselect.disable();
    } else {
      goalSelect.tomselect.enable();
    }

    goalSelect.disabled = walletSelect.value;
    walletSelect.disabled = goalSelect.value;
  }
}
