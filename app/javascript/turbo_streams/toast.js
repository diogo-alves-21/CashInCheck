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
      style: {
        background: 'linear-gradient(to right, #00b09b, #96c93d)'
      },
      escapeMarkup: false
    }).showToast();
  } else if (type === 'alert') {
    Toastify({
      text: message,
      // duration: -1,
      duration: 3000,
      close: true,
      position: position,
      style: {
        background: 'linear-gradient(to right, #8a061e, #e6153b)'
      },
      escapeMarkup: false
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
