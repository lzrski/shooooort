store         = require './store'
App           = require './components/App'
{ render }    = require 'react-dom'
React         = require 'react'

container = document.getElementById 'app'

refresh   = ->
  state = store.getState()
  render <App {...state} />, container

store.subscribe refresh

do refresh
