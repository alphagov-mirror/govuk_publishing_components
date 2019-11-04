/* eslint-env jasmine, jquery */
/* global GOVUK */

describe('Details component', function () {
  var tracker
  var $element

  GOVUK.analytics = {
    trackEvent: function () {}
  }

  var callback = jasmine.createSpy()
  GOVUK.Modules.TrackClick = function () {
    var that = this
    that.start = function () {
      callback()
    }
  }

  beforeEach(function () {
    spyOn(GOVUK.analytics, 'trackEvent')

    $element = $(
      '<details class="gem-c-details govuk-details govuk-!-margin-bottom-3" data-track-category="track-category" data-track-action="track-action" data-track-label="track-label" data-module="govuk-details">' +
        '<summary class="govuk-details__summary" data-details-track-click="">' +
        '<span>Toggle text</span>' +
        '</summary>' +
      '</details>'
    )

    tracker = new GOVUK.Modules.GovukDetails()
  })

  afterEach(function () {
    GOVUK.analytics.trackEvent.calls.reset()
  })

  it('uses built in tracking module when provided with a track-label', function () {
    tracker.start($element)
    $element.find('.govuk-details__summary').trigger('click')

    expect(GOVUK.analytics.trackEvent.calls.count()).toEqual(0)
    expect(callback).toHaveBeenCalled()
  })

  it('does not fire an event if track category and track action are not present', function () {
    $element.attr('data-track-action', null)
    $element.attr('data-track-category', null)
    $element.attr('data-track-label', null)
    tracker.start($element)

    $element.find('.govuk-details__summary').trigger('click')

    expect(GOVUK.analytics.trackEvent.calls.count()).toEqual(0)
  })

  it('tracks open state by default if no track label provided', function () {
    $element.attr('data-track-label', null)
    tracker.start($element)

    $element.find('.govuk-details__summary').trigger('click')

    expect(GOVUK.analytics.trackEvent).toHaveBeenCalledWith('track-category', 'track-action', { label: 'open' })
  })

  it('tracks closed state by default if no track label provided', function () {
    $element.attr('data-track-label', null)
    $element.attr('open', true)
    tracker.start($element)

    $element.find('.govuk-details__summary').trigger('click')

    expect(GOVUK.analytics.trackEvent).toHaveBeenCalledWith('track-category', 'track-action', { label: 'closed' })
  })
})
