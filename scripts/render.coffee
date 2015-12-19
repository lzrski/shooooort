###

Renders React components on every state change and once on application start.

Also sets up clipboard after every DOM update. See components/URLList module.

###

{ render }    = require 'react-dom'
React         = require 'react'
Clipboard     = require 'clipboard'

App           = require './components/App'

module.exports = (store) ->
  { getState, subscribe } = store

  container = document.getElementById 'app'
  update    = ->
    state = store.getState()
    render <App {...state} />, container, -> new Clipboard 'a.url'

  store.subscribe update
  do update
