import { Controller } from '@hotwired/stimulus';
import { TempusDominus } from '@eonasdan/tempus-dominus';

export default class extends Controller {
  static targets = ['monthpicker', 'datepicker', 'datetimepicker', 'timepicker'];

  connect() {
    const icons = {
      type: 'icons',
      time: 'fas fa-clock',
      date: 'fas fa-calendar',
      up: 'fas fa-arrow-up',
      down: 'fas fa-arrow-down',
      previous: 'fas fa-chevron-left',
      next: 'fas fa-chevron-right',
      today: 'fas fa-calendar-check',
      clear: 'fas fa-trash',
      close: 'fas fa-xmar'
    };

    this.datetimepickerTargets.forEach((element) => {
      new TempusDominus(element, {
        display: {
          icons: icons
        },
        localization: {
          format: 'dd-MM-yyyy HH:mm'
        }
      });
    });

    this.datepickerTargets.forEach((element) => {
      new TempusDominus(element, {
        display: {
          icons: icons,
          components: {
            clock: false
          }
        },
        localization: {
          format: 'dd-MM-yyyy'
        }
      });
    });

    this.monthpickerTargets.forEach((element) => {
      new TempusDominus(element, {
        display: {
          icons: icons,
          viewMode: 'months',
          components: {
            clock: false,
            date: false
          }
        },
        localization: {
          format: 'MMM yyyy'
        }
      });
    });

    this.timepickerTargets.forEach((element) => {
      new TempusDominus(element, {
        display: {
          icons: icons,
          components: {
            calendar: false
          }
        },
        localization: {
          format: 'HH:mm'
        }
      });
    });
  }
}
