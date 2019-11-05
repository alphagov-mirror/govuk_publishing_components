/* eslint-env jquery */
// = require govuk/components/details/details.js
window.GOVUK = window.GOVUK || {}
window.GOVUK.Modules = window.GOVUK.Modules || {};

(function (Modules) {
  'use strict'

  Modules.GovukDetails = function () {
    this.start = function (element) {
      var customTrackLabel = element[0].getAttribute('data-track-label')

      // If a custom label has been provided, we can simply call the tracking module
      if (customTrackLabel) {
        var trackDetails = new window.GOVUK.Modules.TrackClick()
        trackDetails.start(element)
      } else {
        // If no custom label is set, we use the open/close status as the label
        var detailsComponent = element[0]
        var summaryElement = detailsComponent.querySelector('[data-details-track-click]')

        $(summaryElement).click(function (e) {
          if (window.GOVUK.analytics && window.GOVUK.analytics.trackEvent) {
            var componentStatus = (detailsComponent.getAttribute('open') == null) ? 'open' : 'closed'
            var trackCategory = detailsComponent.getAttribute('data-track-category')
            var trackAction = detailsComponent.getAttribute('data-track-action')
            var trackOptions = detailsComponent.getAttribute('data-track-options')

            if (typeof trackOptions !== 'object' || trackOptions === null) {
              trackOptions = {}
            }

            trackOptions['label'] = componentStatus

            if (trackAction && trackCategory) {
              window.GOVUK.analytics.trackEvent(trackCategory, trackAction, trackOptions)
            }
          }
        })
      }
    }
  }
})(window.GOVUK.Modules)
