/*
  Toggle the class 'focus' on input boxes on element focus/blur
  Used by the search component but generic enough for reuse
*/
window.GOVUK = window.GOVUK || {}
window.GOVUK.Modules = window.GOVUK.Modules || {};

(function (Modules) {
  function GemToggleInputClassOnFocus () { }

  GemToggleInputClassOnFocus.prototype.start = function ($module) {
    this.$module = $module[0]
    this.toggleTarget = this.$module.querySelector('.js-class-toggle')
    this.$module.addFocusClass = this.addFocusClass.bind(this)
    this.$module.removeFocusClassFromEmptyInput = this.removeFocusClassFromEmptyInput.bind(this)

    if (!this.inputIsEmpty()) {
      this.addFocusClass()
    }

    this.toggleTarget.addEventListener('focus', this.$module.addFocusClass)
    this.toggleTarget.addEventListener('blur', this.$module.removeFocusClassFromEmptyInput)
  }

  GemToggleInputClassOnFocus.prototype.inputIsEmpty = function () {
    return this.toggleTarget.value === ''
  }

  GemToggleInputClassOnFocus.prototype.addFocusClass = function () {
    this.toggleTarget.classList.add('focus')
  }

  GemToggleInputClassOnFocus.prototype.removeFocusClassFromEmptyInput = function () {
    if (this.inputIsEmpty()) {
      this.toggleTarget.classList.remove('focus')
    }
  }

  Modules.GemToggleInputClassOnFocus = GemToggleInputClassOnFocus
})(window.GOVUK.Modules)
