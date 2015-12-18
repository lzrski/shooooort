###

Micro API client library

Constructor takes a base url (e.g. http://gymia-shorty.herokuapp.com/) and returns an object with methods responsible for performing different API calls, (e.g. shorten).

###
URL           = require 'url'

module.exports = (base) ->

  ###

  Reuse headers for different calls. See below.

  ###
  headers = new Headers
    'Content-Type': 'application/json'

  ###

  Return an API client object with methods to perform various API calls///.

  ###
  return (
    ###

    shorten function takes an url to be shortened and returns a promise that resolves to API response from POST /shorten { url }.

    ###
    shorten: (url) ->
      fetch (URL.resolve base, 'shorten'),
        method  : 'post'
        body    : JSON.stringify { url }
        headers : headers

    ###

    get_stats function takes a shortcode and returns a promise that resolves to API response from GET /:shortcode/stats

    ###
    get_stats: (shortcode) ->
      fetch (URL.resolve base, "#{shortcode}/stats"),
        method  : 'get'
        headers : headers
  )
