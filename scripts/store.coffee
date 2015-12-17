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

initial   = Immutable
  urls          : []

shortener = (state = initial, action) ->
  switch action.type
    when 'shorten'
      { url }   = action
      { urls }  = state
      index     = urls.length

      # TODO: Validate data (use typecheck?)

      # TODO: Call API and handle response when it arrives by merging it with URL object

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

module.exports = createStore shortener
