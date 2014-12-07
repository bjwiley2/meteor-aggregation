Meteor.startup ->

  Points.remove {}
  i = 0
  _alphabet = 26

  while i < _alphabet

    i++
    n = Math.ceil(Math.random() * _alphabet)
    Points.insert character: String.fromCharCode(96 + n), n: n
