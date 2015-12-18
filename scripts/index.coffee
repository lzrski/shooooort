# State store
store         = require './store'

# Helper functions
persist       = require './persist'
refresh       = require './refresh'
render        = require './render'

persist store # Setup persistence with localStorage
refresh store # Refresh URL stats every minute
render  store # Render React components now and on every state change 
