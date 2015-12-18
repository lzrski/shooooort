###

Setup persistence layer by dispatching `load` action and subscribing to store and persisting it states.

###

module.exports = (store) ->
  { dispatch, subscribe, getState } = store

  { urls } = localStorage
  try
    urls = JSON.parse urls
  catch error
    urls = []

  dispatch { type: "load", urls }

  subscribe ->
    { urls }          = getState()
    localStorage.urls = JSON.stringify urls

    console.log "persisted", localStorage.urls
