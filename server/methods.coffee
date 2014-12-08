db = MongoInternals.defaultRemoteCollectionDriver().mongo.db

Meteor.methods

  add: ->

    insertPoint()
    console.log "Inserted - now there are #{Points.find().count()} points"


  count: ->

    future = new Future()

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
    db.collection("Points").aggregate pipeline, (err, result) ->
      future.return result

    return future.wait()


  distribution: ->

    future = new Future()

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
      {
        $sort:
          _id: 1
      }
    ]

    # Need to wrap the callback so it gets called in a Fiber.
    db.collection("Points").aggregate pipeline, (err, result) ->
      future.return result

    return future.wait()


  averages: ->

    future = new Future()

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
      {
        $sort:
          _id: 1
      }
    ]

    # Need to wrap the callback so it gets called in a Fiber.
    db.collection("Points").aggregate pipeline, (err, result) ->
      future.return result

    return future.wait()
