import { Controller } from '@hotwired/stimulus';
import { get } from '@rails/request.js';
import TomSelect from 'tom-select';

// USAGE: data: { controller: 'tom-select-remote', tom_select_remote_url_value: root_path, tom_select_remote_options_value: { allowEmptyOption: true } }

export default class extends Controller {
  static values = {
    url: String,
    options: Object
  };

  connect() {
    const defaultConfig = {
      valueField: 'id',
      labelField: 'name',
      searchField: 'name',
      create: false,
      createOnBlur: false,
      loadThrottle: 500,
      render: {
        option: (data) => `<div>${data.name}</div>`,
        item: (data) => `<div>${data.name}</div>`,
        option_create: (data) =>
          `<div class="create">Add new: <strong>${data.input}</strong></div>`
      },
      load: (query, callback) => this.search(query, callback)
    };

    const userOptions = this.optionsValue || {};
    const config = { ...defaultConfig, ...userOptions };

    new TomSelect(this.element, config);
  }

  async search(q, callback) {
    try {
      const response = await get(this.urlValue, {
        query: { q },
        responseKind: 'json'
      });

      if (response.ok) {
        callback(await response.json);
      } else {
        callback();
      }
    } catch (error) {
      console.error('TomSelect search error:', error);
      callback();
    }
  }
}
