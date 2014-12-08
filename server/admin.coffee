@insertPoint = ->

  randomCharCode = Math.ceil(Math.random() * 10)
  randomNum = Math.ceil(Math.random() * 100)

  Points.insert
    character: String.fromCharCode(96 + randomCharCode)
    n: randomNum


Meteor.startup ->

  @Future = Npm.require "fibers/future"

  if Points.find().count() is 0
    i = 0

    while i < 50000

      i++
      insertPoint()
