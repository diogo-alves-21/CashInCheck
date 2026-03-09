import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static values = {
    isOpen: Boolean,
    isSmallWindow: Boolean,
    smallWindow: Number
  };

  static targets = [ 'containerClosed', 'containerOpened', 'contentOpened' ];

  connect() {
    this.smallWindowValue = 600;
    this.element.dataset.bottomNavStatus = 'closed';
    this.changeLayout(this.isSmallWindow());
  }

  toggleNav() {
    if (this.isOpenValue) {
      this.closeNav();

    } else {
      this.openNav();
    }

    this.element.dataset.bottomNavStatus = this.isOpenValue ? 'open' : 'closed';
  }

  openNav() {
    this.containerClosedTarget.style.opacity = 0;
    this.containerClosedTarget.style.height = 0;

    this.containerOpenedTarget.style.height = this.contentOpenedTarget.offsetHeight + 'px';

    this.contentOpenedTarget.style.opacity = 1;
    this.contentOpenedTarget.style.transform = 'translate(0%, 0%)';

    this.isOpenValue = true;
  }

  closeNav() {
    this.containerClosedTarget.style.opacity = 1;
    let biggest_child = 0;
    [...this.containerClosedTarget.children].forEach((child) => {
      if (child.clientHeight > biggest_child) {
        biggest_child = child.clientHeight;
      }
    });

    this.containerClosedTarget.style.height = biggest_child + 'px';

    this.containerOpenedTarget.style.height = 0;

    this.contentOpenedTarget.style.opacity = 0;
    this.contentOpenedTarget.style.transform = 'translate(0%, 100%)';

    this.isOpenValue = false;
  }

  changeLayout(smallWindow) {
    if (smallWindow) {
      this.isSmallWindowValue = true;
      this.element.classList.remove('bottom-nav--desktop');

      this.containerOpenedTarget.style.height = 'auto';

      this.contentOpenedTarget.style.opacity = 1;
      this.contentOpenedTarget.style.transform = 'translate(0%, 0%)';

      document.querySelectorAll('.overlap-page-buttons').forEach((pageButtons) => {
        pageButtons.style.paddingBottom = '0px';
        pageButtons.style.marginTop = '0px';
      });

    } else {
      this.isSmallWindowValue = false;
      this.element.classList.add('bottom-nav--desktop');
      this.closeNav();

      var navRect = this.element.getBoundingClientRect();

      document.querySelectorAll('.overlap-page-buttons').forEach((pageButtons) => {
        var pageButtonsRect = pageButtons.getBoundingClientRect();

        var heightDifference = (navRect.height - pageButtonsRect.height) / 2 ;

        pageButtons.style.marginBottom = heightDifference + 'px';
        pageButtons.style.marginTop = 'auto';
      });
    }
  }

  updateLayout() {
    var isActualWindowSmall = this.isSmallWindow();
    if (!isActualWindowSmall || isActualWindowSmall != this.isSmallWindowValue) {
      this.changeLayout(isActualWindowSmall);
    }
  }

  isSmallWindow() {
    if (window.innerWidth < this.smallWindowValue) {
      return true;
    } else {
      return false;
    }
  }
}
