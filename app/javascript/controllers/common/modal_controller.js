import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['container'];
  static values = { id: String };

  connect() {
  }

  open(event) {
    // Case: single modal (no ID required)
    let modal = document.querySelector(
      '[data-modal-target=\'container\'][data-modal-id-value=\'default-modal\']'
    );

    // Case: ID is specified (multiple modals)
    const button = event.target.closest('[data-action*="modal#open"]');
    const modalId = button.dataset.modalId;

    if (modalId) {
      modal = document.querySelector(
        `[data-modal-id-value='${modalId}']`
      );
    }

    modal.classList.remove('modal--closed');
  }

  close() {
    this.containerTarget.classList.add('modal--closed');
  }
}

