{ render }    = require 'react-dom'
React         = require 'react'
Clipboard     = require 'clipboard'

store         = require './store'
persist       = require './persist'
refresh       = require './refresh'
App           = require './components/App'

persist store
refresh store

container = document.getElementById 'app'
update    = ->
  state = store.getState()
  render <App {...state} />, container, -> new Clipboard 'a.shortened'


store.subscribe update

do update
