config        = require './config'
{
  createStore
}             = require 'redux'
Immutable     = require 'seamless-immutable'
Moment        = require 'moment'
API           = require './API'

###

The structure of `state` is following:

    urls          : [
      shortcode     : <Maybe String>
      url           : <String, URL>
      startDate     : <Moment>
      lastSeenDate  : <Maybe Moment, date>
      redirectCount : <Maybe Number>
    ]

###

api = API config.api.url

initial   = Immutable
  urls          : []

###

Reducer function (here named `shortener`) holds most of the logic of the app.

SEE: https://github.com/rackt/redux#the-gist

###
shortener = (state = initial, action) ->
  console.log "<== #{action.type}"

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

      ###

      startDate and lastSeenDate are coming as Strings. We want Moments for easy manipulation and localization.

      ###
      for key in ['startDate', 'lastSeenDate']
        data[key] = Moment data[key]

      urls      = urls.set index, urls[index].merge data
      return state.merge { urls }

    else
      return state

###

Store is responsible for dispatching actions and supplying state to UI components. See `index` module.

###
store = createStore shortener

module.exports = store
