MiniMongo does not support "aggregate". Other plugins don't provide reactivity:
https://github.com/meteorhacks/meteor-aggregate

This project is a demonstration of a way to overcome this. This is a simple
meteor app demonstrating aggregate data being published and pushed through
methods in a reactive way.

It appears that methods are way faster then publications, but are equally as
reactive in this example.
