config        = require './config'
{
  createStore
}             = require 'redux'
Immutable     = require 'seamless-immutable'
Moment        = require 'moment'

###
The structure of state is following:

    urls          : [
      shortcode     : <Maybe String>
      url           : <String, URL>
      startDate     : <Moment>
      lastSeenDate  : <Maybe Moment, date>
      redirectCount : <Maybe Number>
    ]
###

###

Micro API client library

Constructor takes a base url (e.g. http://gymia-shorty.herokuapp.com/) and returns an object with methods responsible for performing different API calls, (e.g. shorten).

###
URL = require 'url'
API = (base) ->

  headers = new Headers
    'Content-Type': 'application/json'

  return (
    ###

    shorten function takes an url to be shortened and returns a promise that respolves to API response from POST /shorten { url }.

    ###
    shorten: (url) ->
      fetch (URL.resolve base, 'shorten'),
        method  : 'post'
        body    : JSON.stringify { url }
        headers : headers

    get_stats: (shortcode) ->
      fetch (URL.resolve base, "#{shortcode}/stats"),
        method  : 'get'
        headers : headers
  )

api = API 'http://localhost:8080/' # TODO: Use config.api.url

# Reducer function
initial   = Immutable
  urls          : []

shortener = (state = initial, action) ->
  console.log action

  switch action.type
    when 'shorten'
      { url }   = action
      { urls }  = state
      index     = urls.length
      shortcode = null

      # TODO: Validate data (use typecheck?)

      Promise
        .resolve api.shorten url

        .then (res) -> do res.json

        .then (data) ->
          # Store shortcode in outer scope
          { shortcode } = data

        .then -> api.get_stats shortcode

        .then (res) -> do res.json

        .then (data) ->
          Object.assign data, { url }, { shortcode }
          store.dispatch {type: 'shortened', index, data}

        .catch (error) -> throw error

      return state.merge urls: urls.concat { url, startDate: do Moment }

    when 'shortened'
      {
        index
        data
      }         = action
      { urls }  = state
      urls      = urls.set index, urls[index].merge data
      return state.merge { urls }

    else
      return state

store = createStore shortener

module.exports = store
