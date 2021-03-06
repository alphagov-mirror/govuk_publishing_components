/* eslint-disable no-var */

// used by the header navigation from govuk_template

(function () {
  'use strict'

  if (document.querySelectorAll && document.addEventListener) {
    var els = document.querySelectorAll('.js-header-toggle')
    var i
    var _i
    for (i = 0, _i = els.length; i < _i; i++) {
      els[i].addEventListener('click', function (e) {
        e.preventDefault()
        var target = this.getAttribute('href') ? document.getElementById(this.getAttribute('href').substr(1)) : document.getElementById(this.getAttribute('data-search-toggle-for'))
        var targetClass = target.getAttribute('class') || ''
        var sourceClass = this.getAttribute('class') || ''
        var isSearchToggle = sourceClass.match('search-toggle')
        var showText = this.getAttribute('data-show-text') || 'Show search'
        var hideText = this.getAttribute('data-hide-text') || 'Hide search'

        if (targetClass.indexOf('js-visible') !== -1) {
          target.setAttribute('class', targetClass.replace(/(^|\s)js-visible(\s|$)/, ''))
        } else {
          target.setAttribute('class', targetClass + ' js-visible')
        }
        if (sourceClass.indexOf('js-visible') !== -1) {
          this.setAttribute('class', sourceClass.replace(/(^|\s)js-visible(\s|$)/, ''))
          if (isSearchToggle) {
            this.innerText = showText
          }
        } else {
          this.setAttribute('class', sourceClass + ' js-visible')
          if (isSearchToggle) {
            this.innerText = hideText
          }
        }
        this.setAttribute('aria-expanded', this.getAttribute('aria-expanded') !== 'true')
        target.setAttribute('aria-hidden', target.getAttribute('aria-hidden') === 'false')
      })
    }
  }
}).call(this)
