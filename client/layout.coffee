Meteor.subscribe 'PointAverage'
Meteor.subscribe 'PointDistribution'

Template.layout.helpers

  averages: ->
    PointAverage.find {}, { sort: key: 1 }
  distribution: ->
    PointDistribution.find {}, { sort: key: 1 }
  toFixed: (num) ->
    num.toFixed 3
