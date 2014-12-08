Template.layout.rendered = ->

  # Need to reference the source collection(s) of the aggregation to trigger
  # reactivity.  Othwerwise this subscribe is not needed.
  Meteor.subscribe 'Points'

  Tracker.autorun ->

    # Reference the source collection(s) of the aggregation to trigger
    # reactivity. Need to do a count (or something) because meteor is smart and
    # won't trigger reactivity if you simple get a cursor and never use it.
    Points.find().count()

    # Use a random variable to ensure new data is published to subscriptions,
    # otherwise meteor is smart and thinks you are subscribing to the same data
    # over and over again.
    randomSubId = Number(new Date())

    Meteor.subscribe 'PointAverage', randomSubId
    Meteor.subscribe 'PointDistribution', randomSubId
    Meteor.subscribe 'PointCount', randomSubId

    Meteor.call "averages", (error, data) ->
      Session.set "averages", data

    Meteor.call "distribution", (error, data) ->
      Session.set "distribution", data

    Meteor.call "count", (error, data) ->
      Session.set "count", data


Template.layout.helpers

  psAverages: ->
    PointAverage.find {}, { sort: key: 1 }
  psCount: ->
    PointCount.find {}, { sort: key: 1 }
  psDistribution: ->
    PointDistribution.find {}, { sort: key: 1 }
  methodCount: ->
    Session.get "count"
  methodAverages: ->
    Session.get "averages"
  methodDistribution: ->
    Session.get "distribution"
  toFixed: (num) ->
    num.toFixed 3


Template.layout.events

  "click button": ->
    Meteor.call "add"
