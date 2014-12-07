@Points = new Meteor.Collection "Points"
@PointAverage = new Meteor.Collection "PointAverage" if Meteor.isClient
@PointDistribution = new Meteor.Collection "PointDistribution" if Meteor.isClient
