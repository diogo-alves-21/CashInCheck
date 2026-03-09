import { StreamActions } from '@hotwired/turbo';
import Toastify from 'toastify-js';

StreamActions.toast = function() {
  const message = this.getAttribute('message');
  const position = this.getAttribute('position');
  const type = this.getAttribute('type');

  if (type === 'notice') {
    Toastify({
      text: message,
      duration: 3000,
      close: true,
      position: position,
      escapeMarkup: false,
      backgroundColor: '#4fbe87'
    }).showToast();
  } else if (type === 'alert') {
    Toastify({
      text: message,
      // duration: -1,
      duration: 3000,
      close: true,
      position: position,
      escapeMarkup: false,
      backgroundColor: '#f3616d'
    }).showToast();
  } else {
    Toastify({
      text: message,
      duration: 3000,
      close: true,
      position: position,
      escapeMarkup: false
    }).showToast();
  }
};
