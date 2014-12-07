Meteor.publish "PointDistribution", ->

  sub = this

  # This works for Meteor 0.6.5
  db = MongoInternals.defaultRemoteCollectionDriver().mongo.db

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

  # This works for Meteor 0.6.5
  db = MongoInternals.defaultRemoteCollectionDriver().mongo.db

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
