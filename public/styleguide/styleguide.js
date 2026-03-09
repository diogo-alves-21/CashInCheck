function sidenavToggle(e) {
  let elem = e.target
  let sidenav = null

  for (; elem && elem !== document; elem = elem.parentNode) {
    if (elem.matches('nav')) {
      sidenav = elem
    }
  }

  sidenav.querySelector('.styleguide__burger-sidenav').classList.toggle('open')
  sidenav.querySelector('.styleguide__sidenav').classList.toggle('active-menu')

  if (sidenav.querySelector('.styleguide__sidenav').classList.contains('active-menu')) {
    sidenav.querySelector('.styleguide__sidenav').style.width = '300px'
    sidenav.querySelector('.styleguide__burger-box').style.marginLeft = '300px'
  } else {
    sidenav.querySelector('.styleguide__sidenav').style.width = '0px'
    sidenav.querySelector('.styleguide__burger-box').style.marginLeft = '0px'
  }
}

// (function(){

$(document).ready(function() {
  // SIDENAV
  document.getElementById('my_side_nav').addEventListener('click', sidenavToggle)

  // SET UP COLORS
  const x = document.getElementsByClassName('styleguide_card_color')
  for (let i = 0; i < x.length; i++) {
    x[i].querySelector('.styleguide_show_color').style.backgroundColor = x[i].querySelector('.styleguide_color_span').innerHTML
  }

  // document.querySelectorAll('code').forEach(function(element) {
  //   element.innerHTML = element.innerHTML.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/'/g, '&quot;').replace(/'/g, '&#039;');
  // });
})

// })();

$(document).ready(function() {
  $('.styleguide_tabs').click(function() {
    $(this).siblings().removeClass('is-active')
    $(this).addClass('is-active')
    const tab = $(this).data('tab-id')
    $('.styleguide_content[data-tab-id="' + tab + '"]').siblings().hide()
    $('.styleguide_content[data-tab-id="' + tab + '"]').show()
  })

  $('.styleguide_js-example-placeholder-single').select2({
    placeholder: 'Select an option...',
    theme: 'flat',
    allowClear: false
  })
})

document.querySelectorAll('code').forEach(function(element) {
  element.innerHTML = element.innerHTML.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/'/g, '&quot;').replace(/'/g, '&#039;').replace(/#1#/g, '&lt;').replace(/#2#/g, '&gt;')
})
