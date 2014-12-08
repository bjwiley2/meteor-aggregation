db = MongoInternals.defaultRemoteCollectionDriver().mongo.db


Meteor.publish "Points", ->
  # Publish minimal data since client isn't really using it.  Limit seems to
  # break reactivity...
  # TODO: Need a way to not publish everything or else you might as well do the
  # aggregation on the client in forEach loops!
  Points.find {}


Meteor.publish "PointCount", ->

  sub = this

  # Your arguments to Mongo's aggregation. Make these however you want.
  pipeline = [
    {
      $match: {}
    }
    {
      $group:
        _id: "count"
        count:
          $sum: 1
    }
  ]

  # Need to wrap the callback so it gets called in a Fiber.
  db.collection("Points").aggregate pipeline, Meteor.bindEnvironment((err, result) ->

    # Add each of the results to the subscription.
    _.each result, (e) ->

      # Generate a random disposable id for aggregated documents
      sub.added "PointCount", Random.id(),
        key: e._id
        aggregate: e.count

      return

    sub.ready()
    return
  , (error) ->
    Meteor._debug "Error doing aggregation: " + error
    return
  )
  return


Meteor.publish "PointDistribution", ->

  sub = this

  # Your arguments to Mongo's aggregation. Make these however you want.
  pipeline = [
    {
      $match: {}
    }
    {
      $group:
        _id: "$character"
        count:
          $sum: 1
    }
  ]

  # Need to wrap the callback so it gets called in a Fiber.
  db.collection("Points").aggregate pipeline, Meteor.bindEnvironment((err, result) ->

    # Add each of the results to the subscription.
    _.each result, (e) ->

      # Generate a random disposable id for aggregated documents
      sub.added "PointDistribution", Random.id(),
        key: e._id
        aggregate: e.count

      return

    sub.ready()
    return
  , (error) ->
    Meteor._debug "Error doing aggregation: " + error
    return
  )
  return


Meteor.publish "PointAverage", ->

  sub = this

  # Your arguments to Mongo's aggregation. Make these however you want.
  pipeline = [
    {
      $match: {}
    }
    {
      $group:
        _id: "$character"
        avg:
          $avg: "$n"
    }
  ]

  # Need to wrap the callback so it gets called in a Fiber.
  db.collection("Points").aggregate pipeline, Meteor.bindEnvironment((err, result) ->

    # Add each of the results to the subscription.
    _.each result, (e) ->

      # Generate a random disposable id for aggregated documents
      sub.added "PointAverage", Random.id(),
        key: e._id
        aggregate: e.avg

      return

    sub.ready()
    return
  , (error) ->
    Meteor._debug "Error doing aggregation: " + error
    return
  )
  return
