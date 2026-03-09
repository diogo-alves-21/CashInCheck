import { Controller } from '@hotwired/stimulus';
import TomSelect from 'tom-select';

// USAGE: data: { controller: 'tom-select-basic', tom_select_basic_options_value: { allowEmptyOption: true } }

export default class extends Controller {
  static values = {
    options: Object
  };

  connect() {
    console.log(this.element);
    console.log(this.optionsValue);

    const options = {};

    if (this.element.dataset.customTomSelect) {
      switch (this.element.dataset.customTomSelect) {
        case 'select-bank-account':
          this.selectBankAccountTomSelect(options);
          break;
        // add more here if needed
        default:
          // do nothing
      }
    } else {
      new TomSelect(this.element, { ...options, ...this.optionsValue });
    }
  }

  selectBankAccountTomSelect(options) {
    new TomSelect(this.element, { ...options, ...this.optionsValue, render: {
      option: function(data, escape) {
        return `
          <div class="option-item">
            <span class="fs-step-1">${escape(data.account)}</span><br>
            <span>${escape(data.name)} - ${escape(data.iban)}</span>
          </div>
        `;
      },
      item: function(data, escape) {
        return `
          <div class="d-flex gap-1 align-baseline">
            <span class="text--semi-bold">${escape(data.account)}</span>
            <span class="fs-step-2">${escape(data.name)} - ${escape(data.iban)}</span>
          </div>
        `;
      }
    }});
  }
}
