{ render }    = require 'react-dom'
React         = require 'react'
store         = require './store'
persist       = require './persist'
App           = require './components/App'
Clipboard     = require 'clipboard'

persist store

container = document.getElementById 'app'
refresh   = ->
  state = store.getState()
  render <App {...state} />, container, -> new Clipboard 'a.shortened'


store.subscribe refresh

do refresh
