###

Refresh every minute by fetching new data from API and dispatching `shortened` action.

###

API           = require './API'
config        = require './config'

{ get_stats } = API config.api.url

module.exports = (store) ->
  { dispatch, subscribe, getState } = store

  refresh = ->
    { urls }  = getState()
    urls.map (item, index) ->
      Promise
        .resolve get_stats item.shortcode
        .then (res) -> do res.json
        .then (data) -> dispatch { type: 'shortened', index, data}


  setInterval refresh, 60 * 1000
  do refresh
