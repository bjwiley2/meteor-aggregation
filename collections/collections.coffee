@Points = new Meteor.Collection "Points"

if Meteor.isClient
  @PointAverage = new Meteor.Collection "PointAverage"
  @PointDistribution = new Meteor.Collection "PointDistribution"
  @PointCount = new Meteor.Collection "PointCount"
