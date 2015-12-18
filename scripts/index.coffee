{ render }    = require 'react-dom'
React         = require 'react'
store         = require './store'
persist       = require './persist'
App           = require './components/App'

persist store

container = document.getElementById 'app'
refresh   = ->
  state = store.getState()
  render <App {...state} />, container


store.subscribe refresh

do refresh
