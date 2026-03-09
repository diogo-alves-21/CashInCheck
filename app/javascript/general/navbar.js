document.addEventListener('turbo:load', function() {
  accordion();

  const burger = document.querySelector('.burger-menu');
  const nav = document.querySelector('.nav-list');
  const body = document.querySelector('body');

  function toggleNav() {
    burger.classList.toggle('open');
    nav.classList.toggle('nav-list-active');
  }

  if (burger != null) {
    burger.addEventListener('click', function() {
      toggleNav();

      if (body.style.overflow === 'hidden') {
        body.style.overflow = 'auto';
      } else {
        body.style.overflow = 'hidden';
      }
    });
  }

  window.addEventListener('resize', function() {
    body.style.overflow = 'auto';

    if (window.innerWidth <= 1200 && nav != null) {
      nav.classList.remove('nav-list-active');
      burger.classList.remove('open');
    }
  });
});

/* ACCORDION */
function accordion() {
  const dropdown = document.querySelector('.dropdown-button');
  const dropdownContent = document.querySelector('.dropdown-content');

  if (dropdown != null) {
    dropdown.addEventListener('click', function() {
      if (window.innerWidth <= 1200) {
        this.classList.toggle('active-dropdown');
        dropdownContent.classList.toggle('dropdown-content-active');
        setDropdownContentHeight(dropdownContent);
      }
    });
  }
}

function setDropdownContentHeight(dropdownContent) {
  if (dropdownContent.classList.contains('dropdown-content-active')) {
    let contentHeight = 0;
    for (const item of dropdownContent.children) {
      contentHeight += item.offsetHeight;
    }
    dropdownContent.style.height = contentHeight + 'px';
  } else {
    dropdownContent.style.height = 0;
  }
}
